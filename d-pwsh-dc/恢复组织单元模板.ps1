# 查询被删除的组织单元
Get-ADObject -Filter { ObjectClass -eq "organizationalUnit" } -IncludeDeletedObjects -SearchBase (Get-ADDomain).DeletedObjectsContainer

# 找到相关GUID进行恢复
Restore-ADObject -Identity "e419292d-bbf3-4d9d-9b09-34cac1676367"
