---
description: Remove some of the guesswork and docs referencing from AWS CLI.
tags: [AWS, CLI, tech] 
---
# AWS CLI Tab Completion

If you work with AWS, you've probably used the AWS CLI. It's a command line tool for interacting with Amazon Web Services.

Despite having used AWS for years, I only recently made it down to the [end of the config section of the AWS CLI docs](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html) and learned that it's possible to setup tab completion:

```bash
✔ ~/codeexperiments/1dom 
12:33 $ aws dynamodb describe-t<PRESSED TAB>
describe-table      describe-table-replica-auto-scaling     describe-time-to-live 
```

With AWS CLI v1, autocomplete only extends to service names, API actions and some parameters: 

```bash
✔ ~/codeexperiments/1dom 
12:33 $ aws dynamodb describe-table --<PRESSED TAB>
--ca-bundle              --cli-connect-timeout    --cli-read-timeout       --endpoint-url           --no-sign-request        --profile                --table-name
--cli-auto-prompt        --cli-input-json         --color                  --generate-cli-skeleton  --no-verify-ssl          --query                  --version
--cli-binary-format      --cli-input-yaml         --debug                  --no-paginate            --output                 --region 
```

## AWS CLIv2
If you haven't already, I'd highly recommend [upgrading to AWS CLI v2](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html). You probably won't notice much difference day-to-day but it has a [bunch of helpful extra little features](https://github.com/aws/aws-cli/blob/v2/CHANGELOG.rst), including SSO CLI management.

It also expands the autocompletion functionality to include resource names! If your AWS CLI has valid credentials, you can tab complete specific resources in the account that your credentials are configured to access:

```bash
✔ ~/codeexperiments/1dom 
12:33 $ aws dynamodb describe-table --table-name <PRESSED TAB>
1domio-statelock
```

## Setup
The AWS docs are pretty comprehensive on [how to set up autocomplete with various shells and OS.](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-configure)

For my personal laptop setup (Fedora 32 & bash), I was able to squash the process to a oneliner. If you're using bash, and `aws` is in your $PATH, you can probably enable autocomplete with just this:

```bash
echo "complete -C '$(which aws_completer)' aws" >> ~/.bashrc
```

If you're using something other than bash, then I'd recommend you scan through the AWS docs on setting up the CLI. The process in most cases is locate the aws_complete binary, and add a line to your shell setup that adds that binary as an autocompleter.

## tl:dr;

AWS CLI has tab completion support, even down to resource names. [Go read the AWS docs for instructions on setting it up,](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html) or use the oneliner above if you're using bash.