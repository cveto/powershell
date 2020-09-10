"Input file should just be a list of packages with no preceeding spaces and no empty lines at the beginning nor the end"

$url="http://vault.centos.org/7.3.1611/os/x86_64/Packages/"

# Create new folder
rm -r results -ErrorAction SilentlyContinue
mkdir results

# Load file with the list of packages
  "1. Loading file"
$the_list=Get-Content -Path package_list.txt

# Goes to website, scans the site for links that end with .rpm, returns an array of all links
  "2. Downloading website"
$WebSite = Invoke-WebRequest -Uri $url

#Get all links from website
 "3. Scanning for links in the html file ..."
$Links = $WebSite.Links.href

#Get RPM links from website
 "4. Filtering only links that are .rpm files"
$Links_RPM = $Links | Where-Object{$_ -like "*.rpm"}

# Iterate through each line in the list
"5. Entering Foreach loop"

foreach ($line in $the_list) {

  # package name starts here
  $line_start=$line.IndexOF(" ")

  # Get the first thing after space
  $package_name_from_file = $line.Split(" ")[0]
  
  "package_name_from_File"
  $package_name_from_file

  # Rename package name from file + --> \+
  $package_name_from_file = $package_name_from_file -replace "\+",'\+'

  "package_name_from_File after replace"
  $package_name_from_file

   # Check the name from the list agains the database
  "Package name from website:"
  $package_name_from_website = $Links_RPM -match '^'+$package_name_from_file+'-[0-9]'
  $package_name_from_website


  foreach ($found_package in $package_name_from_website) {
    if ($found_package -notmatch "i686") {
        $full_url = $url + $found_package
        
        "Full Download link:"
        $full_url

        "Downloading..."
        Invoke-WebRequest -Uri $full_url -OutFile ./results/$found_package
    }

  }

  "End Loop"
  "\n"
 }


#$Links | Where-Object{$_ -like "zlib*.rpm"}

####
#$data = @('red','green','blue','greenToo','http_something.som.4353.rpm','asdfashttp','http_second')
#$test_str='http'
#$package_name_obj = $data -match '^'+$test_str


