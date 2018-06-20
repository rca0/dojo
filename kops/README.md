## Kops (Kubernetes Operations)

Disclaimer: Launching a Kubernetes cluster hosted on AWS, GCE or DigitalOcean

Tools required:

- kubectl
- kops
- curl

- Export environment variables:

```bash
export AWS_SECRET_ACCESS_KEY="PRrqT5E5Lw8w3zoQX3oPGIgi3RiEjgXs"
export AWS_ACCESS_KEY_ID="AKIAJVQ7MFVGW3LNA"
export KOPS_STATE_STORE="s3://k8s-ruan-us-east-1.domain.io"
export AWS_DEFAULT_REGION="us-east-1"
```

- Create cluster specification

```bash
kops create \
  -f "kops-cluster.yaml" \
  -f "kops-ig-bastion.yaml" \
  -f "kops-ig-master.yaml" \
  -f "kops-ig-nodes.yaml"
```

- Create ssh-key

It is necessary to create the ssh-keys for the nodes.

Private Key:

```bash
ssh-keygen -t rsa -f "k8s-ruan-us-east-1_rsa" -C ""
```

Public Key:

```bash
kops create secret \
    --name "cluster.k8s-ruan-us-east-1.domain.io" \
    sshpublickey admin -i "k8s-ruan-us-east-1_rsa.pub"
```

After the above procedures, it is advisable to check the cluster configurations:

```bash
kops update cluster "cluster.k8s-ruan-us-east-1"
```

After verifying the whole configuration of the cluster, to apply you must to pass `--yes` parameter.

```bash
kops update cluster "cluster.k8s-ruan-us-east-1" --yes
```

After the cluster was created, there are some steps to make the bastion and the api endpoint reachable through the internet by creating entries in the public DNS zone.

- Access route53 in the domain zone
- Get list of nameservers of subdomain as "k8s-ruan-us-east-1"
- Set up in the public zone as "k8s-ruan-us-east-1.domain.io"

Example:

```bash
k8s-ruan-us-east-1.domain.io. 172800 IN	NS	ns-1294.awsdns-33.org.
k8s-ruan-us-east-1.domain.io. 172800 IN	NS	ns-140.awsdns-17.com.
k8s-ruan-us-east-1.domain.io. 172800 IN	NS	ns-1942.awsdns-50.co.uk.
k8s-ruan-us-east-1.domain.io. 172800 IN	NS	ns-553.awsdns-05.net.
```

- Validate created cluster

```bash
dig api.cluster.k8s-ruan-us-east-1.domain.io @8.8.8.8
# check the cluster state
kops validate cluster
```

- Export configuration

```bash
export KUBECONFIG=./cluster.k8s-ruan-east-1.domain.io.conf
kops export \
  kubecfg \
  --name cluster.k8s-ruan-us-east-1.domain.io
```

- Accessing the Cluster

If remote access to the cluster is necessary, for debugging for example, we can access the instances by SSH, with the following commands:

```bash
# adds private key identities to the authentication agent
ssh-add k8s-ruan-us-east-1_rsa
# we need to access by the "admin" username
ssh -A admin@bastion.cluster.k8s-ruan-us-east-1.domain.io
```

- Deleting the Cluster

```bash
kops delete cluster \
  --name "cluster.k8s-ruan-us-east-1.domain.io" \
  --yes
```

This will remove all resources that kops has provisioned.

We also need to delete the custom DNS entries api.cluster and bastion.cluster that we created prior into the public k8s-ruan-east-1.domain.io zone, so the CloudFormation can delete the zone later.

To remove all the resources, we can invoke CloudFormation again to delete the resources in the following order: s3, route53 and vpc.

- Rolling-Update

After update the version of kubernetes in kops cluster files:

```bash
kops rolling-update cluster --yes
```

- Kops Replace

If you want to change some specification, after that, to apply, is is necessary run:

```bash
kops replace -f arquivo.yaml
# OR directly access
kops edit ig master-us-east-1
```
