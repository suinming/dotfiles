#!/bin/bash 
#! /usr/bin/env zsh
# get the project name as the variable
projectName=$1
# create the nuxt3 app in the current directory 
npx nuxi init $projectName 
# get in to the project directory
cd $projectName
# install all the dependencies
npm i
# install the typescript
npm i typescript vue-tsc
