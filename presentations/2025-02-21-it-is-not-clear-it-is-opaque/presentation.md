## If it is not clear, it's _Opaque_

## 🕶️

---

## Definition

Opaque types do not have any special syntax.
They are essentially types (not type aliases) whose constructor functions are not exposed from the module.

---

## Why?

To have a _clear separation_ of what the consumers of the module/component need to know and **_hide the internal implementation_**.

---

## How?

[.code-highlight: 1,4]
[.code-highlight: 2,4]

```elm
module Password exposing (Password(..))
module Password exposing (Password)

type Password = Secret
```

---

Let's try it
🙌

---

## Builder pattern

---

[.code-highlight: 1]
[.code-highlight: 2-4]
[.code-highlight: 5]

```elm
Button.primary
    |> Button.withText "Click me!"
    |> Button.withType Button.button
    |> Button.withOnClick OnClick
    |> Button.render
```

---

## Unofficial Rule of Thumb for components 👍

- Opaque _configuration_ initializer is called _`config`_
- Opaque _configuration_ functions start with _`with*`_
- Opaque _model_ initializer is called _`init`_
- Opaque _model_ functions start with _`set*`_
- Model and configuration gets passed to _`render`_

---

## Example Configuration

```elm
Button.config
  |> Button.withText "Click me"
```

---

## Example Model

```elm
Input.init
  |> Input.setValue "Hello"
```

---

Let's build something
🏗️
