import json


def input_validation(data, filepath):
    """
    This method take input service  property and check for input validation

    :param data (list of define services ) and filepath where json file
    for rules defined:
    :return note or flag:
    """
    verificationResult = {'result': 'NoRule'}
    withoutfile = filepath.split('/')[:-1]
    absfilepath = '/'.join(withoutfile)
    fullfilepath = absfilepath + '/configurations/nagios/validationRule.json'


    with open(fullfilepath) as rulefile:
        rule = json.loads(rulefile.read())
        for i in range(0, len(data)):
            service = data[i]
            if 'service_description' in service:
                for key, value in rule.items():
                    if service['service_description'] == \
                            rule[key]['service_description']:
                        if rule[key]['format_Value'] == 'percentage':
                            check_command = service['check_command']
                            warn = check_command.split("!")[1][:-1]
                            critical = check_command.split("!")[2][:-1]
                        else:
                            check_command = service['check_command']
                            warn = check_command.split("!")[1]
                            critical = check_command.split("!")[2]

                        if not (int(warn) >= int(
                                rule[key]['max_value']) or int(warn) <= int(
                                rule[key]['min_value']) or int(
                                critical) >= int(
                                rule[key]['max_value']) or int(
                                critical) <= int(rule[key]['min_value'])):

                            if (int(warn) <= int(
                                    rule[key]['max_limit']) and int(
                                    warn) >= int(
                                rule[key]['min_limit']) and int(
                                critical) <= int(
                                rule[key]['max_limit']) and int(
                                critical) >= int(rule[key]['min_limit'])):

                                verificationResult['service_description'] = \
                                    service['service_description']
                                verificationResult['result'] = 'success'

                            else:
                                verificationResult['service_description'] = \
                                    service['service_description']
                                verificationResult['result'] = 'failed'
                                verificationResult[
                                    'errMsg'] = "Mentioned value is not " \
                                                "acceptable,(accepted value " \
                                                "should in a range of " \
                                                "{0} and {1})" \
                                    .format(rule[key]['min_limit'],
                                            rule[key]['max_limit'])
                        else:
                            verificationResult['service_description'] = service[
                                'service_description']
                            verificationResult['result'] = 'failed'
                            verificationResult[
                                'errMsg'] = "Value mentioned is out of " \
                                            "the range should be in range " \
                                            "of {0} to {1}".\
                                format(rule[key]['min_value'],
                                       rule[key]['max_value'])

        return verificationResult


if __name__ == "__main__":
    data = [{
        "hostgroup_name": "ssh-servers",
        "use": "generic-service",
        "check_command": "check_ssh",
        "notification_interval": "0",
        "service_description": "SSH"
    }
    ]
    print input_validation(data)
