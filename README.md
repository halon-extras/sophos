# Sophos anti-virus, DLP and anti-spam clients

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

Scan a File pointer (fp) with the Sophos anti-virus and DLP engine (over the SSSP protocol). If attachements are scanned separately, change the `rfc822` options to false.

**Params**

- fp `File` - the mail file
- options `array` - options array

The following options are available in the **options** array.

- rfc822 `boolean` - Scan the content as a "rfc822" message (do not rely on auto-detection). The default is true.
- timeout `number` - Timeout in seconds. The default is 5 seconds.
- path `string` - Path to a the savdid unix socket. The default is `/var/run/sssp.sock`
- address `string` - Address of the savdid server.
- port `number` - TCP port of the savdid server.

**Returns**

An associative array, with a `virus` property containing a list of viruses found (array of strings). Additional properties may include `tft.types`, `dlp.ccl` and `sandbox` recommendation depending on savdid settings. If an error occures an `error` property (string) is set contaning the error message.

**Example**

```
import { sophos_av } from "extras://sophos";

$sophos = sophos_av($mail->toFile());
if ($sophos["virus"])
  Reject("Virus found");
```

### sophos_as(fp[, options])

Scan a File pointer (fp) with the Sophos anti-spam.

**Params**

- fp `File` - the mail file
- options `array` - options array

The following options are available in the **options** array.

- timeout `number` - Timeout in seconds. The default is 5 seconds.
- address `string` - Address of the sasi daemon (lased) server.
- port `number` - TCP port of the sasi daemon (lased) server.
- bec `data` - data from `sophos_bec()`

**Returns**

An associative array with all `X-LASED-` headers included (without the prefix). Spam determination should use the `Spam` array value (`Confirmed` or `NonSpam`). If an error occures an `error` property (string) is set contaning the error message.

**Example**

```
import { sophos_as } from "extras://sophos";

$sophos = sophos_as($mail->toFile());
if ($sophos["Spam"] == "Confirmed")
  Reject("Spam");
```

### sophos_bec(fp[, options])

Scan a File pointer (fp) with Sophos BEC

**Params**

- fp `File` - the mail file
- options `array` - options array

The following options are available in the **options** array.

- timeout `number` - Timeout in seconds. The default is 5 seconds.
- address `string` - Address of the BEC server.
- port `number` - TCP port of the BEC server.

**Returns**

An associative array with a `bec` property, for use with `sophos_as()`. If an error occures an `error` property (string) is set contaning the error message.