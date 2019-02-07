#!/bin/sh

cd ./resource-git-smoketests-dashboard/

# Compile elm code
elm-make --yes elm/AppStyles.elm elm/Main.elm elm/Model.elm elm/View.elm elm/TestResult/Model.elm elm/TestResult/View.elm --output wwwroot/js/main.js

# Publish dotnet core app
dotnet publish -c Release -r ubuntu.14.04-x64

# Push to CF
cf login -a $api -u $username -p $password -o $organization -s $space &&\
cf push -f $manifest
