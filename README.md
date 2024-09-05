
# AWS S3 Static Website Hosting with Terraform

This project sets up a static website hosted on AWS S3 using Terraform. It includes infrastructure deployment for hosting a website using an S3 bucket with public access.

## Prerequisites

Before you begin, ensure you have the following:

- **AWS Account**: Make sure you have an AWS account with the necessary permissions.
- **Terraform**: Install Terraform by following the [official guide](https://www.terraform.io/downloads.html).
- **AWS CLI**: Install and configure the AWS CLI for managing AWS resources. Learn more [here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html).

## Setup and Usage

### Clone this repository:

```bash
git clone https://github.com/aryamanmaurya/s3-static-website-hosting.git
cd s3-static-website-hosting
```

### Initialize Terraform:

Run the following command to initialize the working directory, downloading the necessary providers:

```bash
terraform init
```

### Configure Variables:

You can update the default values for the variables in the `variables.tf` file or pass them as arguments during deployment.

Key variables defined in the `variables.tf` file:

- **region**: AWS region where the resources will be deployed (default: `ap-south-1`).
- **bucket**: The name of the S3 bucket (default: `thisismydemobucketfornow`).

### Deploy the Infrastructure:

To deploy the S3 static website hosting infrastructure, run:

```bash
terraform apply
```

Review the plan and type `yes` to proceed.

### Destroy the Infrastructure:

If you need to tear down the infrastructure, run the following command:

```bash
terraform destroy
```

## Configuration Details

### Resources Created:

- **S3 Bucket**: The bucket will be configured to host a static website with public access.
- **Bucket Policy**: The bucket will have a policy that makes the contents publicly accessible for hosting a website.

### Key Variables (defined in `variables.tf`):

- **region**: The AWS region where the S3 bucket will be created (default: `ap-south-1`).
- **bucket**: The name of the S3 bucket (default: `thisismydemobucketfornow`).

### Outputs (defined in `outputs.tf`):

- **bucket_website_endpoint**: The S3 bucket website URL for accessing the hosted site.

## Example Website

The HTML and CSS files provided (`index.html` and `styles.css`) will be uploaded to the S3 bucket and served as a static website. Customize them to create your own content.

- **index.html**: Main HTML file with a profile and contact section.
- **styles.css**: Stylesheet for the HTML file.

## Notes

- Ensure the AWS region specified is valid and that the bucket name is unique globally.
- Make sure public access settings and bucket policy align with your requirements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
