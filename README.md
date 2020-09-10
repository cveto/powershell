*** Old centos repos download***
- The point of this is to go on http://vault.centos.org/7.3.1611/os/x86_64/Packages/ and download only those packages that are list in the `package_list.txt` file.
- You can get the list of full dependencies (e.g. for apache) with `yum install httpd --downloadonly --installroot=/tmp --downloaddir=. --disablerepo=* --enablerepo=base `
- In order to get this to work, you must have no empty lines or any prepending spaces in the list.
- This script ignores i686 packages
