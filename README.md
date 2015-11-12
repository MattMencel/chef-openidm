# openidm cookbook

Installs and configures [OpenIDM](http://forgerock.com/products/open-identity-stack/openidm/).

## Supported Platforms

* CentOS
 * 7 (tested)

## Attributes

Except for default[:java][:jdk_ version] attribute, all tunable attributes are
in the `openidm` hierarchy.

Key | Type | Description | Default
:---|:---|:---|:---
`default[:java][:jdk_version]` | String | JDK Version | 7
`version` |  String | OpenIDM version to install | 4.0.0-SNAPSHOT
`url` | String | URL to download the OpenIDM 4 package from nightlies | ''
`path` | String | Install path | /opt/openidm
`db_user` | String | MySQL DB user for OpenIDM | 'openidm'
`db_pass` | String | MySQL DB password for OpenIDM | 'openidm'

## Usage

### openidm::default

Installs and configures the OpenIDM package.

## LWRP

*THIS IS DEPRECATED*

You cannot use a template resource to deploy the repo.jdbc.json config file
because the OpenIDM service will open and modify that file outside of Chef. I
wrote the LWRP to do the following:

- Open the config file and lock it to prevent other services from editing it.
- Modify one of the JSON 'connection' attributes.
- Save the config file and unlock it.

It works in that I know it will edit any entry in the connection block. However
if a system service or OpenIDM ignores file lock attributes it may not matter. I
also don't know whether this is really the best way to do this, but it seems to
work.

```

## License and Authors

- Author:: Matt Mencel (<matt@techminer.net>)

```text
Copyright:: 2015 Matt Mencel

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
