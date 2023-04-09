# Akamai Redirect Checker

---
The Akamai Redirect Checker is a script which checks provided URLs against the staging network of Akamai. It does this by getting the first CNAME of a domain (which usually is the Akamai CNAME) and get its value. Then it simply changes the CNAME value to the staging version and get its IP. It also supports the production network to quickly check if implemented changes work.

## Dependencies

---
Make sure you have Python3 installed.
This module uses the following Python packages
* urllib3
* dnspython
* requests
* openpyxl

```shell
pip3 install urllib3 dnspython requests argparse openpyxl 
```

Or use the provided `setup.sh` script. This script will install Python3 and its dependencies together with the required Python packages. It will also prompt you to create the `archer` command.

## Usage

---

### Manually provide source only
One of the options is to provide a source only. The script will return the final destination of the source with its status code.

Example:
 ```shell
python archer.py -s https://www.philips-hue.com/support
```

Expected result:
```shell
[200] https://www.philips-hue.com/nl-nl/support/faq
```

### Manually provide source and destination
When you provide a source _with_ a destination the script will check if the final destination matches the provided destination.

Example:
 ```shell
python archer.py -s https://www.philips-hue.com/support -d https://www.philips-hue.com/nl-nl/support/faq
```

Expected result:
```shell
[Success] Redirect works!
```

### Provide a file with sources and destinations
Example:
 ```shell
python archer.py -f redirects.xlsx
```

Result example:
```shell
[1][Success] Redirect works!
[2][Failed] Final destination does not match target URL!
[3][Success] Redirect works!
[4][Success] Redirect works!
```

### Relaxed source and/ or destination flags
The redirect check requires a protocol in the URL to function, **https** for example. This is why you'll need to provide
a full URL. This can however be 'omitted'. By using the `--relaxed-destination` or `--relaxed-source` flags.

These flags are available for the sole reason to make working with files easier. Some customers do not include the http
or https protocol in their request files. By using `--relaxed-source` we will automatically add the http port to URLs
that do not have a protocol defined. The same principle applies to the destination URL with `--relaxed-destination`.

### Script flags

| Flag                           | Function                                                                                                      |
|:-------------------------------|:--------------------------------------------------------------------------------------------------------------|
| `-h`, `--help`                 | Shows the help message                                                                                        |
| `-f`, `--file`                 | Provide a file with two columns in which the first has the source and the second has the destination URLs.    |
| `-s`, `--source`               | URL that needs to be redirected. Will print the destination with status code if provided without destination. |
| `-d`, `--destination`          | Excepted destination URL. Will show if the redirect is successful by returning a success or fail message.     |
| `-rs`, `--relaxed-source`      | Relaxes the matching criteria by auto adding http:// to the source URL if it is missing.                      |
| `-rd`, `--relaxed-destination` | Relaxes the matching criteria by auto adding https:// to the destination URL if it is missing.                |
| `-p`, `--production`           | Routes DNS requests over the production network instead of staging.                                           |
| `-v`, `--verbose`              | Displays the found config and redirect trace.                                                                 |