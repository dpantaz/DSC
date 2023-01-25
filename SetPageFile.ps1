Configuration SetPageFile {
    
    Import-DscResource -ModuleName ComputerManagementDsc
    Import-DscResource -ModuleName StorageDSC

    Node localhost {
    
        LocalConfigurationManager {
            RebootNodeIfNeeded = $true
        }

        WaitforDisk Disk2
        {
            DiskId           = 2
            RetryIntervalSec = 30
            RetryCount       = 3
        }

        Disk Disk2 {
            DiskId      = 2
            DriveLetter = 'T'
            DependsOn   = '[WaitForDisk]Disk2'
        }

        VirtualMemory PagingSettings
        {
            Type        = 'CustomSize'
            Drive       = 'T'
            InitialSize = '2048'
            MaximumSize = '2048'
            DependsOn   = '[Disk]Disk2'
        }
    }

}