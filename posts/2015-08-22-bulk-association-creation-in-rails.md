+++
date = "2015-08-22"
draft = false
title = "Bulk association creation with ActiveRecord"
tags = [ "rails", "ruby", "activerecord" ]
+++

During development of an application I stumbled across a situation that could be
improved. The application contains posts that are automatically tagged based on
the content. Beneath you can see all the models that are used in this situation.

```ruby
class Post < ActiveRecord::Base
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  after_save :tag_content, if: :content_changed?

  private

  def tag_content
    words = content.strip.downcase.split(/\W+/)
    TaggingService.new(self).tag(words)
  end
end
```

```ruby
class Tagging < ActiveRecord::Base
  belongs_to :taggable, polymorphic: true
  belongs_to :tag
end
```

```ruby
class Tag < ActiveRecord::Base
  has_many :taggings
end
```

When the content of a post is changed it passes the words to a service which
tags the post. It deletes all the current taggings to make sure irrelevant tags
are removed. Then it walks through all the tags that are stored. Below is the
tagging service which is responsible for the automatic tagging.

```ruby
class TaggingService
  def initialize(record)
    @record = record
  end

  def tag(words)
    @record.taggings.destroy_all
    Tag.all.each do |tag|
      record.tags << tag if words.include? tag.name
    end
  end
end
```

The first problem with this service is that it walks through all the tags, even
the ones that aren’t present in the content. We could improve this by only
fetching relevant tags. By changing the query we can skip the check if the tag
name is included.

```ruby
def tag(words)
  @record.taggings.destroy_all
  Tag.where(name: words).each do |tag|
    record.tags << tag
  end
end
```

It’s an improvement, but still walks through each tag and as a result produces
N+1 queries. After looking through the source of Rails I’ve found that it’s
possible to pass a `ActiveRecord::Relation` instance at the `CollectionProxy` of
the post instance. A CollectionProxy is an object that is responsible for
associating records, in this case the post with its taggings and tags.

Rails would use the `ActiveRecord::Relation` instance to generate a query and
skip fetching data from the database. This would reduce the time spent in Ruby
code. To improve our example we just pass in the query we improved earlier.

```ruby
def tag(words)
  @record.taggings.destroy_all
  @record.tags << Tag.where(name: words)
end
```

This generates a nice SQL `INSERT` query that would look like the query below.

```sql
INSERT INTO "taggings" ("taggable_type", "taggable_id", "tag_id", "created_at", "updated_at")
VALUES ("Post", 1, 1, "2015-08-22 00:00:00.000000", "2015-08-22 00:00:00.000000")
```
