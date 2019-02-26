---
jupyter:
  jupytext:
    text_representation:
      extension: .md
      format_name: markdown
      format_version: '1.0'
      jupytext_version: 0.8.6
  kernelspec:
    display_name: Python 3
    language: python
    name: python3
---

## Open file and read from it

```python
alice_file = open("Alice_in_wonderland.txt")
```

```python
type(alice_file)
```

```python
alice_file.read?
```

```python
alice_text = alice_file.read()
```

```python
print(alice_text)
```
