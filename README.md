# Sophos anti-virus client

## Installation

Follow the [instructions](https://docs.halon.io/manual/comp_install.html#installation) in our manual to add our package repository and then run the below command.

### Ubuntu

```
apt-get install halon-extras-sophos
```

### RHEL

```
yum install halon-extras-sophos
```

## Exported functions

These functions needs to be [imported](https://docs.halon.io/hsl/structures.html#import) from the `extras://sophos` module path.

### sophos_av(fp[, options])

Scan a File pointer (fp) with the Sophos anti-virus.

**Params**

- fp `File` - the mail file
- options `array` - options array

The following options are available in the **options** array.

- timeout `number` - Timeout in seconds. The default is 5 seconds.
- path `string` - Path to a the savdid unix socket. The default is `/var/run/sssp.sock`
- address `string` - Address of the savdid server.
- port `number` - TCP port of the savdid server.

**Returns**

An associative array, with a `virus` property containing a list of viruses found (array of strings). If an error occures an `error` property (string) is set contaning the error message.

**Example**

```
import { sophos_av } from "extras://sophos";

$sophos = sophos_av($mail->toFile());
if ($sophos["virus"])
  Reject("Virus found");
```
