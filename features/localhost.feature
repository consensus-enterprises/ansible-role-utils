Feature: Running Ansible against localhost
  In order to run Ansible tests inside CI
  As a developer
  I need to be able to run Ansible test playbooks against localhost

  Scenario: Run Ansible test playbook with --check
     Given I run "(which ansible-playbook || make ansible) && ansible-playbook tests/test.yml -i tests/inventory --check --connection=local"
     Then I should get:
      """
      TASK [consensus.utils : Increase PHP CLI memory limit.]
      changed: [localhost]
      PLAY RECAP
      localhost                  : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
      """
