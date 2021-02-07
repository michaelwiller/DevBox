
# GitHub recommended scripts

## The Idea

If your scripts are normalized by name across all of your projects, your
contributors only need to know the pattern, not a deep knowledge of the
application. This means they can jump into a project and make contributions
without first learning how to bootstrap the project or how to get its tests to
run.

The intricacies of things like test commands and bootstrapping can be managed by
maintainers, who have a rich understanding of the project''s domain. Individual
contributors need only to know the patterns and can simply run the commands and
get what they expect.

## The Scripts

Each of these scripts is responsible for a unit of work. This way they can be
called from other scripts.

This not only cleans up a lot of duplicated effort, it means contributors can do
the things they need to do, without having an extensive fundamental knowledge of
how the project works. Lowering friction like this is key to faster and happier
contributions.

The following is a list of scripts and their primary responsibilities.

### script/bootstrap

**bootstrap** is used solely for fulfilling dependencies of the project.

This can mean RubyGems, npm packages, Homebrew packages, Ruby versions, Git submodules, etc.

The goal is to make sure all required dependencies are installed.

### script/setup

**setup** is used to set up a project in an initial state.
This is typically run after an initial clone, or, to reset the project back to
its initial state.

This is also useful for ensuring that your bootstrapping actually works well.

### script/update

**update** is used to update the project after a fresh pull.

If you have not worked on the project for a while, running **update** after
a pull will ensure that everything inside the project is up to date and ready to work.

Typically, **bootstrap** is run inside this script. This is also a good
opportunity to run database migrations or any other things required to get the
state of the app into shape for the current version that is checked out.

### script/server

**server** is used to start the application.

For a web application, this might start up any extra processes that the 
application requires to run in addition to itself.

**update** should be called ahead of any application booting to ensure that
the application is up to date and can run appropriately.

### script/test

**test** is used to run the test suite of the application.

A good pattern to support is having an optional argument that is a file path.
This allows you to support running single tests.

Linting (i.e. rubocop, jshint, pmd, etc.) can also be considered a form of testing. These tend to run faster than tests, so put them towards the beginning of a **test** so it fails faster if there''s a linting problem.

**test** should be called from **cibuild**, so it should handle
setting up the application appropriately based on the environment. For example,
if called in a development environment, it should probably call **update**
to always ensure that the application is up to date. If called from
**cibuild**, it should probably reset the application to a clean state.


### script/cibuild

**cibuild** is used for your continuous integration server.
This script is typically only called from your CI server.

You should set up any specific things for your environment here before your tests
are run. Your test are run simply by calling **test**.

### script/console

**console** is used to open a console for your application.

A good pattern to support is having an optional argument that is an environment
name, so you can connect to that environment''s console.

You should configure and run anything that needs to happen to open a console for
the requested environment.

