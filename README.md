# cloud
Assignment #3
Once this directory exists on a Ubuntu VM, change the contents of the
clouds.yaml file based on your Chameleon account, then execute the following
commands within the folder:
In the home directory, execute the following command:
> source CH-822922-openrc.sh
When prompted, enter the Chameleon password.
Execute the following playbooks in order:
playbook_run_all.yml
playbook_start_kubernetes_VM2.yml
SSH into VM3 and VM4 and run the following command based on the output of the
kube init command:
> kubeadm join 10.60.5.20:6443 --token <TOKEN> --discovery-token-ca-cert-hash <DISCOVERY_TOKEN>
