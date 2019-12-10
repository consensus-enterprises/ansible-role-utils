Feature: Running Ansible against localhost
  In order to run Ansible tests inside CI
  As a developer
  I need to be able to run Ansible test playbooks against localhost

  Scenario: Run Ansible test playbook with --check
# TODO: delete or migrate tests concerning PHP memory limit to our geerlingguy.php fork
#     Given the following files do not exist:
#     """
#     /etc/php/7.2/cli/conf.d/20-memory_limit.ini
#     """
     When I run "make ansible-role-check"
     Then I should get:
     """
     ok: [localhost]
     """
#     TASK [consensus.utils : Increase PHP CLI memory limit.]
#     changed: [localhost]
#     And the following files should not exist:
#     """
#     /etc/php/7.2/cli/conf.d/20-memory_limit.ini
#     """
#
#  @wip
#  Scenario: Run Ansible test playbook to change localhost PHP CLI memory limit
#     Given the following files do not exist:
#     """
#     /etc/php/7.2/cli/conf.d/20-memory_limit.ini
#     """
#     When I run "make ansible-role-test"
#     Then I should get:
#     """
#     TASK [consensus.utils : Increase PHP CLI memory limit.]
#     changed: [localhost]
#     """
#     And the following files should exist:
#     """
#     /etc/php/7.2/cli/conf.d/20-memory_limit.ini
#     """
#     And the file "/etc/php/7.2/cli/conf.d/20-memory_limit.ini" should contain:
#     """
#     This file is managed by Ansible. Any changes will be reverted. See the infrastructure repository to apply persistent changes to this file.
#     419M
#     """
#     # Test idempotence:
#     When I run "make ansible-role-test"
#     Then I should not get:
#     """
#     changed: [localhost]
#     """
#
#  @wip
#  Scenario: When not running in CI, we need to clean up.
#     # Clean up:
#     When I run "sudo rm /etc/php/7.2/cli/conf.d/20-memory_limit.ini"
#     Then the following files should not exist:
#     """
#     /etc/php/7.2/cli/conf.d/20-memory_limit.ini
#     """
