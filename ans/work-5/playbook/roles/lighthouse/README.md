Lighthouse
=========

This role installs nginx, which is required for Lighthouse to run, downloads Lighthouse from the repository, and creates a lighthouse configuration file for nginx.

Role Variables
--------------

| variable | description |
| -------- | ----------- |
| `lighthouse_url` | path to the Lighthouse repository |

Example Playbook
----------------

```yaml
- name 'Play name'   
  hosts: servers   
  roles:   
    - lighthouse
```

License
-------

MIT

Author Information
------------------

Yaroslav Lysenko
