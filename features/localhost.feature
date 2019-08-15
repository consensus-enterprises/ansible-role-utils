Feature: Running Ansible against localhost
  In order to run Ansible tests inside CI
  As a developer
  I need to be able to run Ansible test playbooks against localhost

  Scenario: Run Ansible test playbook with --check
     Given I run "php -i|grep memory_limit"
     And I do not get:
     """
     419M
     """
     #TODO: make this a make target; make tests/test.yml and tests/inventory overridable 
     When I run "ansible-playbook tests/test.yml -i tests/inventory --connection=local --check"
     Then I should get:
     """
     TASK [consensus.utils : Increase PHP CLI memory limit.]
     changed: [localhost]
     """
     When I run "php -i|grep memory_limit"
     Then I should not get:
     """
     419M
     """

  @debug
  Scenario: Run Ansible test playbook to change localhost PHP CLI memory limit
     Given I run "php -i|grep memory_limit"
     And I do not get:
     """
     419M
     """
     #TODO: make this a make target
     When I run "ansible-playbook tests/test.yml -i tests/inventory --connection=local"
     Then I should get:
     """
     TASK [consensus.utils : Increase PHP CLI memory limit.]
     changed: [localhost]
     """
     And the following files should exist:
     """
     /etc/php/7.2/cli/conf.d/20-memory_limit.ini
     """
     And the file "/etc/php/7.2/cli/conf.d/20-memory_limit.ini" should contain:
     """
     This file is managed by Ansible. Any changes will be reverted. See the infrastructure repository to apply persistent changes to this file.
     """
     When I run "cat /etc/php/7.2/cli/conf.d/20-memory_limit.ini"
     Then I should get:
     """
     419M
     """
     When I run "php -i|grep memory_limit"
     Then I should get:
     """
     419M
     """
     # Test idempotence:
     #TODO: make this a make target
     When I run "ansible-playbook tests/test.yml -i tests/inventory --connection=local"
     Then I should not get:
     """
     changed: [localhost]
     """
     When I run "php -i|grep memory_limit"
     Then I should get:
     """
     419M
     """
