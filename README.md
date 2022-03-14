# UnityPack github action

Create an Unity Package from directory

## Inputs
### `package-dir`
**Required** directory path of unity package relative to unity project directory

### `output-path`
path of .unitypackage file

### `project-dir`
directory of unity project


## Example usage

```yaml
uses: quabug/unity-pack@v1
with:
  package-dir: 'Packages/com.quabug.graph-ext'
```
