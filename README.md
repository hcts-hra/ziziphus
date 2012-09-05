Ziziphus Project Quickstart Guide
===================================

Installation
---------------------------------------------

    * Download eXist db / betterFORM bundle at: http://betterform.de/ziziphus/betterform-install-eXist-2.0-20120302.jar
        and install it (The install dir is called $BETTERFORM_HOME).

    * Download ziziphus.xar at http://betterform.de/ziziphus/ziziphus-0.1.xar
        or create it by executing 'ant xar' in the root of the Ziziphus project.
        The result will be placed at $ZIZIPHUS_HOME/build/ziziphus-<version>.xar

    * Start the eXist database (double click on $BETTERFORM_HOME/betterFORM.jar or execute
        $BETTERFORM_HOME/bin/startup.sh) and deploy ziziphus-<version>.xar using the eXist
        Package Repository at http://localhost:8080/betterform/admin/admin.xql?panel=repo

    * Run Ziziphus by following the link given by selecting the installed Ziziphus XAR.

123abc