import os


def callansible(service,host):
    # type: (str, str) -> None

    """
    Method is defined to call the Ansible playbook to execute the healing script
    on given host ip to resolve the given service problem.
    :param service: Monitoring agent service to resolve
    :param host: Monitoring agent host ip
    :return: None
    """

    if service == 'apache2':
        os.system("ansible -m shell -a 'sudo /etc/init.d/apache2 restart' " + host
                  + " --private-key=/home/centos/playbooks/runcommandplaybook/devopslabs-prakteek-key.pem -u ubuntu")
    else:
        os.system("ansible-playbook /home/centos/playbooks/runsamplescript.yml "
                  "--extra-var 'scriptname=deletelogs.sh hostname=" + host
                  + "' --private-key=/home/centos/playbooks/runcommandplaybook/devopslabs-prakteek-key.pem -u ubuntu")


def retry(service,host):
    # type: (str, str) -> None

    """
    Method is defined to recall Ansible playbook once it got failed.
    :param service: Monitoring agent service to resolve
    :param host: Monitoring agent host ip
    :return: None
    """
    callansible(service=service,host=host)


