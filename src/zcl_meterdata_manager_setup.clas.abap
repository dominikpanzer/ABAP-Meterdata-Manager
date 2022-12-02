CLASS zcl_meterdata_manager_setup DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_meterdata_manager_setup IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA meterreadingresults TYPE TABLE OF zeabl.
    DELETE FROM zeabl.
    meterreadingresults = VALUE #( ( ablbelnr = '1001' adat = '20210101' zaehlerstand = '100' vertrag = '1004254252')
                                   ( ablbelnr = '1002' adat = '20210201' zaehlerstand = '110' vertrag = '1004254252')
                                   ( ablbelnr = '1003' adat = '20210301' zaehlerstand = '115' vertrag = '1004254252')
                                   ( ablbelnr = '1004' adat = '20210401' zaehlerstand = '127' vertrag = '1004254252')
                                   ( ablbelnr = '1005' adat = '20210501' zaehlerstand = '200' vertrag = '1004254252')
                                   ( ablbelnr = '1006' adat = '20210601' zaehlerstand = '201' vertrag = '1004254252')
                                   ( ablbelnr = '1007' adat = '20210701' zaehlerstand = '234' vertrag = '1004254252')
                                   ( ablbelnr = '1008' adat = '20210801' zaehlerstand = '234' vertrag = '1004254252')
                                   ( ablbelnr = '1009' adat = '20210901' zaehlerstand = '300' vertrag = '1004254252')
                                   ( ablbelnr = '1010' adat = '20211001' zaehlerstand = '310' vertrag = '1004254252')
                                   ( ablbelnr = '1011' adat = '20211101' zaehlerstand = '330' vertrag = '1004254252') ).
    INSERT zeabl FROM TABLE @meterreadingresults.

  ENDMETHOD.
ENDCLASS.
