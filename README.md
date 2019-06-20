Role Name
=========

This role serves as a library of tasks that can be shared between roles.

Usage
-----

In another role:

```yaml
  tasks:
  - name: Create bind mounts.
    include_role:
      name: consensus.utils
      tasks_from: bind-mounts.yml
    vars:
      bind_mounts:
        - foo
        - bar
```

License
-------

AGPL-v3

Author Information
------------------

Dan Friedman (@lamech) and Christopher Gervais (@ergonlogic)
