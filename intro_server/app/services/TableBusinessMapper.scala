package services

import models.containeres.info.{BusinessInfo, TableInfo}

import collection.mutable

class TableBusinessMapper {

    private val tableBusinessMap = mutable.Map.empty[String, BusinessInfo]
    private val businessTablesMap = mutable.Map.empty[String, List[TableInfo]].withDefaultValue(List())

    def addTable(tableInfo: TableInfo, businessInfo: BusinessInfo): Unit = {
        tableBusinessMap.getOrElseUpdate(tableInfo.id, businessInfo)
        businessTablesMap(businessInfo.id) =  tableInfo :: businessTablesMap(businessInfo.id).filterNot(_.id == tableInfo.id)
    }


    def getTableBusiness(tableInfo: TableInfo): Option[BusinessInfo] = tableBusinessMap.get(tableInfo.id)
    def getBusinessTables(businessInfo: BusinessInfo): List[TableInfo] = businessTablesMap(businessInfo.id)

}
