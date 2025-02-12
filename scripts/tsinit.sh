#!/bin/bash

npx npm init;
npx npm install -D tsx typescript @types/node;
npx tsc --init
touch index.ts;
echo "console.log(\"hello world\")" > index.ts;
sed -i '/"scripts": {/a \\t \ \"start\": \"node index.ts\",' package.json;

echo 'done, `npm run start` to run your project';
