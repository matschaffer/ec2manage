ec2manage
=========

NOTE: Currently this project is vaporware. Consider this documentation-driven-development.

ec2manage will be a command line tool for managing EC2 instances.

It's main goal is to provide the same style of control as the Amazon EC2 API Tools but with additional structure and metadata make administrative decisions easier.

Installation
============

    gem install ec2manage

ec2manage will read your `EC2_PRIVATE_KEY` and `EC2_CERT` environment variables if you've already defined them for the Amazon EC2 API Tools. Or if you only plan to use ec2manage, you can just drop your `pk-*.pem` and `cert-*.pem` in `~/.ec2manage`.

ec2manage uses SDB for storing nicknames for instances and volumes so you'll need to also have your SDB access credentials available.

Usage
=====

Creating machines
-----------------

Create a new Ubuntu 9 machine with 10GB blank EBS on /dev/sdi1 nicknamed "beta" in the web security group:

    > ec2manage create --zone us-east-1d --ami ami-bb709dd2 --keypair my-keypair \
                       --group web --volume-size 10 --snapshot snap-6a0a8c03 \
                       --device sdi --name beta

Of course, specifying this every time would be tedious, so you can also build machine templates in JSON. The above machine would look like this:

    { "zone":    "us-east-1d",
      "ami":     "ami-bb709dd2",
      "keypair": "my-keypair",
      "group":   "web",
      "volumes": [
        { "size":     10,
          "snapshot": "snap-6a0a8c0",
          "device":   "sdi" }
      ] }

You can save this template as a file and load it with `-t`:

    > ec2manage create -t web.json -n beta

If ec2manage can't find the specified path in the current directory it will attempt to load the file from `~/.ec2manage/web.json`. In this case you could also omit the extension and just use `-t web`.

Additionally, if you omit all configuration options, ec2manage will try to load `~/.ec2manage/default.json`.

Create a new ec2 instance and ssh into it:

    > ec2manage create -c "ssh %"

The external hostname of the instance is passed to the command string using `String#%`. See [Kernel.sprintf](http://ruby-doc.org/core/classes/Kernel.html#M005962) for details on how this function works.

Naming machines
---------------

You can get a JSON list of all images and volumes by running ec2manage with no arguments:

    > ec2manage list

You can also give your instances new nicknames using the rename command:

    > ec2manage rename i-12345 staging

Deleting machines
-----------------

And finally you can remove machines as well as their associated volumes by using the delete command with the `-v` flag:

    > ec2manage delete staging -v

If you have an unassociated volume you can delete it by name as well:

    > ec2manage delete v-12345
