#!/bin/sh

cd ./resource-git-smoketests-dashboard/

# Compile elm code
elm-make --yes elm/Main.elm elm/View.elm elm/Model.elm elm/AppStyles.elm elm/TestResult/Main.elm --output wwwroot/js/main.js

# Publish dotnet core app
dotnet publish -c Release -r ubuntu.14.04-x64

# Push to CF
cf login -a $api -u $username -p $password -o $organization -s $space &&\
cf push -f $manifest
