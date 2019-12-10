Consensus: Utils
================

This role provides a library of tasks that can be shared between roles.

Usage
-----

In your role, include the task file desired. Right now the only task available
ensures the creation of bind mounts; more may be added in future.

Bind Mounts
-----------

Use the `bind-mounts.yml` tasks to create [bind mounts](https://unix.stackexchange.com/questions/198590/what-is-a-bind-mount) on the target server.

To configure this task, populate the `bind_mounts` list variable. The format is:

```yaml
bind_mounts:
  '/target/path':
    src: '/source/path'
    owner: someuser
    group: somegroup
  ...
```

For each item in the list, the task will:

    1. Ensure any existing data in the target path is copied into the source path before bind mount creation.
    1. Ensure a bind mount from the source path is created at the target path.
    1. Ensure group and user ownership for the bind mount.

Note: for each bind mount, all 4 configuration elements (source, target, owner and group) are required.

Example Playbook
----------------

```yaml
  tasks:
  - name: Create bind mounts.
    include_role:
      name: consensus.utils
      tasks_from: bind-mounts.yml
    vars:
      bind_mounts:
        '/var/aegir':
          src: '/opt/var/aegir'
          owner: aegir
          group: aegir
        '/var/aegir/backups':
          src: '/opt/var/aegir/backups'
          owner: aegir
          group: aegir
        '/var/lib/mysql':
          src: '/opt/var/lib/mysql'
```

Dependencies
------------

None, other than Ansible itself; this is all accomplished with Ansible builtins.

License
-------

GNU AGPLv3

Author Information
------------------

[Christopher Gervais](https://consensus.enterprises/team/christopher/) and [Dan Friedman](https://consensus.enterprises/team/dan/), with contributions from the folks at [Consensus Enterprises](https://consensus.enterprises). To contact us, please use our [Web contact form](https://consensus.enterprises/#contact).
