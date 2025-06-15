default:
  @just --list

install:
  npm install
install__ci:
  npm ci

format:
  npx prettier --write .

lint__format:
  npx prettier --check .

lint__eslint:
  npx eslint .
lint__eslint__fix:
  npx eslint --fix .

lint__stylelint:
  npx stylelint --ignore-path .gitignore **/*.css

lint__commitlint:
  npx commitlint --last --verbose

test:
  npx ng test
test__watch:
  npx ng test --watch --browsers Chrome

build:
  npx ng build
build__watch:
  npx ng build --watch --configuration development
