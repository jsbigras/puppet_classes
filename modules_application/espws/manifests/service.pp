# Class: espws::service
# This module manage the services of the espws component on the server.
#

class espws::service {

	exec { 'start_espws':
		command	=> 'su - ozimps -c \'nmp start espws\'',
		path	=> ['/home/ozimps/bin','/bin'],
		unless	=> 'su - ozimps -c \'nmp check espws\' | grep \'is running\'',
		require	=> Class['espws::config'],
	}

	exec { 'populate_espws_db':
		command	=> "su - ozimps -c \"java -jar /opt/nokia/nmp/instances/espws/application/tools/espws-ccsimporter.jar -c http://${ipaddress}:${v_port_espws} -e /home/ozimps/espws-ccsimporterError.log -f /opt/nokia/nmp/instances/espws/application/tools/data/CCSExport.xml -o /home/ozimps/espws-ccsimporterOutput.log\"",
		path	=> ['/home/ozimps/bin','/bin','/usr/bin'],
		onlyif	=> 'su - ozimps -c \'nmp check espws\' | grep \'is running\'',
		unless	=> "su - ozimps -c \"mysql ${sch_sql_col_tbl[0]} -u${sch_sql_col_tbl[0]} -p${sch_pwd} -h${db_master} -e 'SELECT * from serviceprovider where ${sch_sql_col_tbl[2]} = 1862;'\"",
		require	=> Exec['start_espws'],
	}

} # End of class espws::service
