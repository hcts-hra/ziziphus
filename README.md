# Ziziphus Installation

1. git clone this repository
2. call 'ant xar' to create the xar application
3. import a dataset into the database under the collection 'db/apps/ziziphusData. A working data set (Priya Paul collection) can also be found under https://github.com/betterFORM/zizphusData.git. To install this clone the repository and call ant xar in the root of the resulting working dir. This will create a data xar that works with the application.
4. install the xar application into eXist using the package manager from the dashboard of eXist.
5. clicking the Ziziphus icon opens an overview page listing the existing dataset. By clicking a link on the left the corresponding record will be opened.

Note:
Starting with version 0.6 you'll need to update the betterform.jar in eXist as it contains improvements that are needed for Ziziphus.

To do so follow these steps:

1. find your eXist installation
2. cd into the extensions/betterform/main/lib directory and copy the betterform.jar from the 'lib' directory of your ziziphus workspace to this location.

