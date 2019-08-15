Feature: Running Ansible against localhost
  In order to run Ansible tests inside CI
  As a developer
  I need to be able to run Ansible test playbooks against localhost

  Scenario: Run Ansible test playbook with --check
     Given I run "sudo mv /etc/php/7.2/cli/conf.d . || /bin/true"
     Then the following files should not exist:
      """
      /etc/php/7.2/cli/conf.d
      """
     And I run "(which ansible-playbook || make ansible) && ansible-playbook tests/test.yml -i tests/inventory --check --connection=local"
     Then I should get:
      """
      TASK [consensus.utils : Increase PHP CLI memory limit.]
      changed: [localhost]
      PLAY RECAP
      localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
      """
      And I run "sudo mv ./conf.d /etc/php/7.2/cli/ || /bin/true"
     Then the following files should not exist:
      """
      ./conf.d
      """

  Scenario: Run Ansible test playbook to change localhost PHP CLI memory limit
     Given I run "sudo mv /etc/php/7.2/cli/conf.d . || /bin/true"
     Then the following files should not exist:
      """
      /etc/php/7.2/cli/conf.d
      """
     And I run "(which ansible-playbook || make ansible) && ansible-playbook tests/test.yml -i tests/inventory --connection=local"
     Then I should get:
      """
      TASK [consensus.utils : Increase PHP CLI memory limit.]
      changed: [localhost]
      PLAY RECAP
      localhost                  : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
      """
     And the following files should exist:
      """
      /etc/php/7.2/cli/conf.d/20-memory_limit.ini
      """
      And the file "/etc/php/7.2/cli/conf.d/20-memory_limit.ini" should contain:
      """
      ; configuration for increasing PHP CLI memory limit
      ; priority=20
      memory_limit = 512M
      """
      And I run "sudo rm /etc/php/7.2/cli/conf.d/20-memory_limit.ini"
      And I run "sudo mv ./conf.d/* /etc/php/7.2/cli/conf.d || /bin/true"
      And I run "sudo rm -rf ./conf.d"
     Then the following files should not exist:
      """
      ./conf.d
      """
