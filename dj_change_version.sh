#!/bin/sh

release=${1-"trunk"}
django_base=${2-"$HOME/django"}
site_packages=${3-"/Library/Python/2.5/site-packages"}

echo "removing old django symbolic link"
rm -rf $site_packages/django

echo "checking for release in django folder"
if ! [ -d $django_base/$release/ ]
then
    echo "getting release $release from django repository   "
    cd $django_base
    svn co http://code.djangoproject.com/svn/django/trunk/ -r$release $release
fi

echo "creating symbolic link to \"$release\""
cd $site_packages
ln -s $django_base/$release/django django

echo "creating symbolic link to django-admin.py"
sudo rm -rf /usr/local/bin/django-admin.py
sudo ln -s $django_base/$release/django/bin/django-admin.py /usr/local/bin/django-admin.py