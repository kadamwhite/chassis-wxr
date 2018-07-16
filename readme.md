# chassis-wxr

A module to import content from [WXR (**W**ordPress e**X**tended **R**SS) files](https://codex.wordpress.org/Importing_Content) into your [Chassis](https://github.com/Chassis/Chassis) virtual machine. For information on Chassis itself, see the [Chassis documentation](http://docs.chassis.io/en/latest/).

## Configuration & Usage

In your Chassis yaml configuation file, add a new `wxr` key with a `path` property:

```yaml
wxr:
  path: ./path/to/wordpress-export.xml
```

The `path` property should specify the (content-directory-relative) file system path of a WordPress WXR XML file.
