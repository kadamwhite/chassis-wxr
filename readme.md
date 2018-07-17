# chassis-wxr

A module to import content from [WXR (**W**ordPress e**X**tended **R**SS) files](https://codex.wordpress.org/Importing_Content) into your [Chassis](https://github.com/Chassis/Chassis) virtual machine. For information on Chassis itself, see the [Chassis documentation](http://docs.chassis.io/en/latest/).

## Configuration & Usage

In your Chassis yaml configuation file, add a new `wxr` key with a `path` property:

```yaml
wxr:
  path: path/to/wordpress-export.xml
```

The `path` property should specify the file system path of a WordPress WXR XML file, relative to the content directory. For example, if you have a WXR called "theme-test-data.xml" in the `content/` folder of your Chassis site, you should pass `path: theme-test-data.xml`.

### `empty: true`

In situations where the WXR represents the sum total of the content intended to be displayed on the site, you may specify an additional `empty` property to cause Chassis to empty all content from the database prior to loading the WXR.

```yaml
wxr:
  path: path/to/wordpress-export.xml
  clean: true
```
