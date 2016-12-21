EnableExplicit

Define XML.s
Define Event

#XmlEncoding = #PB_UTF8
#Dialog = 0
#Xml = 0

Runtime Enumeration Window
  #Main_Window
  #Help_Window
  #About_Window
EndEnumeration

Runtime Enumeration	Gadget
  #Load_CIF1
  #Load_CIF2
  #Load_CIF3
  #Load_CIF4
  #Load_CIF5
  #Clear_all
  #Help
  #About
  #Exit
  #Copy_RTF   
  #Copy_LaTex
  #Copy_MD
  #Copy_Plain
  #Save_RTF    
  #Save_LaTex 
  #Save_MD
  #Save_Plain
  #Include_T
  #Include_Moiety
  #SI_Units
  #A4_Auto
  #A4_Portrait
  #A4_Landscape
  #Editor
  #Text_Help_1
  #Text_Help_2
  #Editor_Help
  #OK_Help
  #Text_About_1
  #Text_About_2
  #Editor_About
  #OK_About
EndEnumeration

Structure Units
  Unit_Asc.s
  Unit_MD.s
  Unit_RTF.s
  Unit_LTX.s
EndStructure

Structure Summenformel
  Alles.s
  Elemente.s
  Anzahl.s
EndStructure

Structure Moietyformel
  Alles.s
  Element_u_Anzahl.s
  Elemente.s
  Anzahl.s
  Ladung.s
  Trennung.s
  Aufklammer.s
  Zuklammer.s
EndStructure

Global Name_of_Structure_1.s
Global Name_of_Structure_2.s
Global Name_of_Structure_3.s
Global Name_of_Structure_4.s
Global Name_of_Structure_5.s

Global NewList CIF1.s()
Global NewList CIF2.s()
Global NewList CIF3.s()
Global NewList CIF4.s()
Global NewList CIF5.s()

Global NewList Sum_Formula_1.Summenformel()
Global NewList Sum_Formula_2.Summenformel()
Global NewList Sum_Formula_3.Summenformel()
Global NewList Sum_Formula_4.Summenformel()
Global NewList Sum_Formula_5.Summenformel()

Global NewList Moiety_Formula_1.Moietyformel()
Global NewList Moiety_Formula_2.Moietyformel()
Global NewList Moiety_Formula_3.Moietyformel()
Global NewList Moiety_Formula_4.Moietyformel()
Global NewList Moiety_Formula_5.Moietyformel()

Global NewList ItemsToExtract.s()

Global NewList Plain_Ascii.s()
Global NewList MD_Ascii.s()
Global NewList LaTeX.s()
Global NewList RTF.s()

Global NewMap SI_Units.Units()
Global NewMap Units.Units()
Global NewMap SPG_Dict_RTF.s()
Global NewMap SPG_Dict_Markdown_Ascii.s()
Global NewMap SPG_Dict_Latex.s()

Global NewMap CIF_Items_1.s()
Global NewMap CIF_Items_2.s()
Global NewMap CIF_Items_3.s()
Global NewMap CIF_Items_4.s()
Global NewMap CIF_Items_5.s()

Declare LoadCIF(List CIF.s(),Gadget.i)                                        ; Load CIF
Declare Fill_Units_Dict()                                                     ; Fill units dict
Declare Fill_SPG_Dict_RTF()                                                   ; Fill space group dict RTF
Declare Fill_SPG_Dict_Markdown_Ascii()                                        ; Fill space group dict Markdown
Declare Fill_SPG_Dict_Latex()                                                 ; Fill space group dict LaTeX
Declare Get_Name_of_Structure(List CIF.s(),Gadget.i)                          ; Get name of structure
Declare Get_Sum_Formula(List CIF.s(),Gadget.i)                                ; Get sum formula
Declare Get_Moiety_Formula(List CIF.s(),Gadget.i)                             ; Get moity formula
Declare Items_to_extract_from_CIF()                                           ; List of item to extract
Declare Extract_Items_from_CIF(List ItemsToExtract.s(),List CIF.s(),Gadget.i) ; Read items form CIF and extract ItmesToExtract 
Declare Create_Ascii()                                                        ; Create plain text file
Declare Create_Markdown()                                                     ; Create Markdown file
Declare Create_LaTeX()                                                        ; Create LaTeX file
Declare Create_RTF()                                                          ; Create LaTeX file
Declare.i CopyRichTextToClipboard(rtf.s)                                      ; Copy RTF to clipboard
Declare.s HKL_entry_Ascii(Map CIF_Items.s())                                  ; Create hkl range line for plain text file
Declare Save_File(Type.s)                                                     ; Save tables

XML.s =  "<dialogs>" +
         "<window id='#Main_Window' name='TableMasterG2' text='TableMasterG2' minwidth='1024' minheight='768' flags='#PB_Window_ScreenCentered | #PB_Window_SystemMenu | #PB_Window_SizeGadget | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget'>" +
         "      <gridbox columns='6' colspacing = '5' colexpand='item:2' rowspacing = '5' rowexpand='item:3'>" +
         "         <frame colspan='5' text='Load'>" +
         "          <hbox colspan='5'>"+
         "            <button id='#Load_CIF1'  text='Load CIF 1' width='80' height='30' disabled ='no'  onevent='LoadCIF1_RT()'/>" +
         "            <button id='#Load_CIF2'  text='Load CIF 2' width='80' height='30' disabled ='yes' onevent='LoadCIF2_RT()'/>" +
         "            <button id='#Load_CIF3'  text='Load CIF 3' width='80' height='30' disabled ='yes' onevent='LoadCIF3_RT()'/>" +
         "            <button id='#Load_CIF4'  text='Load CIF 4' width='80' height='30' disabled ='yes' onevent='LoadCIF4_RT()'/>" +
         "            <button id='#Load_CIF5'  text='Load CIF 5' width='80' height='30' disabled ='yes' onevent='LoadCIF5_RT()'/>" +
         "          </hbox>" +
         "         </frame>" +
         "         <frame rowspan='5'>" +
         "          <vbox rowspan='5' expand='no'>" +
         "            <button id='#Clear_all'   text='Clear all'        width='40' height='40' onevent='Clear_all()'/>" +
         "            <button id='#Help'        text='Help'             width='40' height='40' onevent='Help()'/>" +
         "            <button id='#About'       text='About'            width='40' height='40' onevent='About()'/>" +
         "            <button id='#Exit'        text='Exit'             width='40' height='40' onevent='Exit()'/>" +
         "          </vbox>" +
         "         </frame>" +
         "         <frame colspan='5' text='Options'>" +
         "          <hbox colspan='5' expand='no'>"+
         "            <checkbox id='#Include_T'        text='Include Temperature'    onevent='Include_T()'/>" +
         "            <checkbox id='#Include_Moiety'   text='Include Moeity Formula' onevent='Include_Moiety()'/>" +
         "            <checkbox id='#SI_Units'         text='SI Units'               onevent='Switch_SI_Units()'/>" +
         "            <option id='#A4_Auto'            text='A4 Auto'                onevent='A4_Orientation()'/>" +
         "            <option id='#A4_Portrait'        text='A4 Portrait'            onevent='A4_Orientation()'/>" +
         "            <option id='#A4_Landscape'       text='A4 Landscape'           onevent='A4_Orientation()'/>" +
         "          </hbox>" +
         "         </frame>" +
         "         <frame colspan='5' text='Plain text preview (RTF, LaTeX and Markdown outputs will look different, but contain essentially the same information).'>" + 
         "            <editor id='#Editor' colspan='5' height='150' flags='#PB_Editor_ReadOnly'/>" +
         "         </frame>" +
         "         <frame colspan='5' text='Copy'>" +
         "          <hbox colspan='5'>"+
         "            <button id='#Copy_RTF'    text='Copy RTF'         width='80' height='30' disabled ='yes' onevent='Copy_RTF()'/>" +
         "            <button id='#Copy_LaTex'  text='Copy LaTeX'       width='80' height='30' disabled ='yes' onevent='Copy_LaTeX()'/>" +
         "            <button id='#Copy_MD'     text='Copy Markdown'    width='80' height='30' disabled ='yes' onevent='Copy_MD()'/>" +
         "            <button id='#Copy_Plain'  text='Copy plain text'  width='80' height='30' disabled ='yes' onevent='Copy_Plain()'/>" +
         "          </hbox>" +
         "         </frame>" +
         "         <frame colspan='5' text='Save'>" +
         "          <hbox colspan='5'>"+
         "            <button id='#Save_RTF'    text='Save RTF'         width='80' height='30' disabled ='yes' onevent='Save_RTF()'/>" +
         "            <button id='#Save_LaTex'  text='Save LaTeX'       width='80' height='30' disabled ='yes' onevent='Save_LaTeX()'/>" +
         "            <button id='#Save_MD'     text='Save Markdown'    width='80' height='30' disabled ='yes' onevent='Save_MD()'/>" +
         "            <button id='#Save_Plain'  text='Save plain text'  width='80' height='30' disabled ='yes' onevent='Save_Ascii()'/>" +
         "          </hbox>" +
         "         </frame>" +
         "      </gridbox>" +
         "</window>" +
         "<window id='#Help_Window' name='Help_Me' text='Tablemaster G2 - Help' minwidth='640' minheight='480' flags='#PB_Window_ScreenCentered | #PB_Window_SystemMenu | #PB_Window_SizeGadget | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget'>" +
         "  <vbox expand='item:3'>" +
         "    <text id='#Text_Help_1' text='TableMasterG2 (v1.0 beta)' flags='#PB_Text_Center'/>" +
         "    <text id='#Text_Help_2' text='(c) 2016 - Sebastian Dechert' flags='#PB_Text_Center'/>" +
         "    <editor id='#Editor_Help' height='150' flags='#PB_Editor_ReadOnly|#PB_Editor_WordWrap'/>" +
         "    <button id='#OK_Help' text='Thanks, that helped a lot!' width='80' height='30' onevent='Close_Help()'/>" +
         "  </vbox>" +
         "</window>" +
         "<window id='#About_Window' name='About_Me' text='Tablemaster G2 - About' minwidth='640' minheight='480' flags='#PB_Window_ScreenCentered | #PB_Window_SystemMenu | #PB_Window_SizeGadget | #PB_Window_MinimizeGadget | #PB_Window_MaximizeGadget'>" +
         "  <vbox expand='item:3'>" +
         "    <text id='#Text_About_1' text='TableMasterG2 (v1.0 beta)' flags='#PB_Text_Center'/>" +
         "    <text id='#Text_About_2' text='(c) 2016 - Sebastian Dechert' flags='#PB_Text_Center'/>" +
         "    <editor id='#Editor_About' height='150' flags='#PB_Editor_ReadOnly|#PB_Editor_WordWrap'/>" +
         "    <button id='#OK_About' text='OK' width='80' height='30' onevent='Close_About()'/>" +
         "  </vbox>" +
         "</window>" +
         "</dialogs>"


; If LoadFont(0, "Sans Serif", 10)
;   SetGadgetFont(#PB_Default, FontID(0))  
; EndIf

Fill_Units_Dict()
Fill_SPG_Dict_RTF()             
Fill_SPG_Dict_Markdown_Ascii()  
Fill_SPG_Dict_Latex() 
Items_to_extract_from_CIF()

CompilerIf #PB_Compiler_OS = #PB_OS_Linux
  
  DeclareC get_func(clipboard,selection_data,info,user_data)
  
  gtk_init_(0,0)
  
  Enumeration
    #TARGET_STRING
    #TARGET_RTF
  EndEnumeration
  
  ImportC ""
    gtk_selection_data_set_text_(*selection_data.GtkSelectionData,str.p-ascii,len) As "gtk_selection_data_set_text"
    gtk_selection_data_set_(*selection_data.GtkSelectionData,type,format,datas.p-ascii,length) As "gtk_selection_data_set"
    gtk_clipboard_store_(*clipboard) As "gtk_clipboard_store"
    gtk_clipboard_set_can_store_(*clipboard,*targets,n_targets) As "gtk_clipboard_set_can_store"
  EndImport
  
  Global Dim targets.GtkTargetEntry(2)
  Define *mem_STRING
  Define *mem_textrtf
  Define GDK_SELECTION_CLIPBOARD
  
  ;*mem_STRING=AllocateMemory(StringByteLength("STRING") + SizeOf(Character), #PB_Ascii)
  *mem_STRING=AllocateMemory(StringByteLength("STRING") + SizeOf(Character))
  PokeS(*mem_STRING,"STRING",-1,#PB_Ascii)
  
  ;*mem_textrtf=AllocateMemory(StringByteLength("text/rtf") + SizeOf(Character), #PB_Ascii)
  *mem_textrtf=AllocateMemory(StringByteLength("text/rtf") + SizeOf(Character))
  PokeS(*mem_textrtf,"text/rtf",-1,#PB_Ascii)
  
  targets(0)\target=*mem_STRING
  targets(0)\flags=0
  targets(0)\info=#TARGET_STRING
  
  targets(1)\target=*mem_textrtf
  targets(1)\flags=0
  targets(1)\info=#TARGET_RTF
  
  Global n_targets=ArraySize(targets()) ; Anzahl der Targets
  Global clipboard=gtk_clipboard_get_(GDK_SELECTION_CLIPBOARD)
  
  ProcedureC get_func(clipboard,selection_data,info,user_data) ;copy RTF to clipboard
    Protected rtf.s
    Protected length.i
    rtf.s=PeekS(user_data,-1,#PB_Ascii)
    length=Len(rtf.s)
    Select info
      Case #TARGET_STRING
        gtk_selection_data_set_text_(selection_data,rtf,length)
      Case #TARGET_RTF
        gtk_selection_data_set_(selection_data,gdk_atom_intern_("text/rtf", #False),8,rtf,length)
    EndSelect
    ;g_free_(*user_data)
  EndProcedure
  
CompilerEndIf


If CatchXML(#Xml, @XML.s, StringByteLength(XML.s), 0, #XmlEncoding) And XMLStatus(#Xml) = #PB_XML_Success
  If CreateDialog(#Dialog) And OpenXMLDialog(#Dialog, #Xml, "TableMasterG2")
    
    SetGadgetState(#Include_T, #PB_Checkbox_Checked)
    SetGadgetState(#A4_Auto, 1) 
    
    GadgetToolTip(#Load_CIF1, "open file") 
    GadgetToolTip(#Load_CIF2, "open file") 
    GadgetToolTip(#Load_CIF3, "open file") 
    GadgetToolTip(#Load_CIF4, "open file") 
    GadgetToolTip(#Load_CIF5, "open file") 
    GadgetToolTip(#Clear_all, "clear everything") 
    GadgetToolTip(#Help, "display help window") 
    GadgetToolTip(#About, "display about window")
    GadgetToolTip(#Exit, "close the program immediately")
    GadgetToolTip(#Include_T, "include _diffrn_ambient_temperature") 
    GadgetToolTip(#Include_Moiety, "include _chemical_formula_moiety") 
    GadgetToolTip(#SI_Units, "display '/unit' instead of '[unit]'") 
    GadgetToolTip(#A4_Auto, "switch page orientation") 
    GadgetToolTip(#A4_Portrait, "switch page orientation") 
    GadgetToolTip(#A4_Landscape, "switch page orientation") 
    GadgetToolTip(#Copy_RTF, "copy RTF table to clipboard")
    GadgetToolTip(#Copy_LaTex, "copy LaTeX table to clipboard")
    GadgetToolTip(#Copy_MD, "copy Markdown table to clipboard")
    GadgetToolTip(#Copy_Plain, "copy plain text table to clipboard")
    GadgetToolTip(#Save_RTF, "save RTF table")
    GadgetToolTip(#Save_LaTex, "save LaTeX table")
    GadgetToolTip(#Save_MD, "save Markdown table")
    GadgetToolTip(#Save_Plain, "save plain text table")

    If LoadFont(1, "Consolas", 10)
      SetGadgetFont(#Editor, FontID(1))  
    EndIf
    
    CompilerIf #PB_Compiler_OS = #PB_OS_Linux ; since there is no Consolas font in Linux
      If LoadFont(1, "inconsolata", 10)
        SetGadgetFont(#Editor, FontID(1))   
      EndIf
    CompilerEndIf
    
    Repeat
      Event = WaitWindowEvent()
      If  Event = #PB_Event_CloseWindow And EventWindow() = #Help_Window
        CloseWindow(#Help_Window)
      ElseIf Event = #PB_Event_CloseWindow And EventWindow() = #About_Window
        CloseWindow(#About_Window)
      EndIf
    Until Event = #PB_Event_CloseWindow And EventWindow() = #Main_Window
    
  Else  
    MessageRequester("Dialog error!", "Dialog error: " + DialogError(#Dialog), #PB_MessageRequester_Ok | #PB_MessageRequester_Error)
  EndIf
Else
  MessageRequester("XML error!", "XML error: " + XMLError(#Xml) + " (Line: " + XMLErrorLine(#Xml) + ")", #PB_MessageRequester_Ok | #PB_MessageRequester_Error)
EndIf

Runtime Procedure LoadCIF1_RT()
  LoadCIF(CIF1.s(),#Load_CIF1)
  If ListSize(CIF1.s())
    DisableGadget(#Load_CIF2,#False)
    DisableGadget(#Copy_Plain,#False)
    DisableGadget(#Copy_MD,#False)
    DisableGadget(#Copy_LaTex,#False)
    DisableGadget(#Copy_RTF,#False)
    DisableGadget(#Save_Plain,#False)
    DisableGadget(#Save_MD,#False)
    DisableGadget(#Save_LaTex,#False)
    DisableGadget(#Save_RTF,#False)
  EndIf
EndProcedure

Runtime Procedure LoadCIF2_RT()
  LoadCIF(CIF2.s(),#Load_CIF2)
  If ListSize(CIF2.s())
    DisableGadget(#Load_CIF3,#False)
  EndIf
EndProcedure

Runtime Procedure LoadCIF3_RT()
  LoadCIF(CIF3.s(),#Load_CIF3)
  If ListSize(CIF3.s())
    DisableGadget(#Load_CIF4,#False)
  EndIf
EndProcedure

Runtime Procedure LoadCIF4_RT()
  LoadCIF(CIF4.s(),#Load_CIF4)
  If ListSize(CIF4.s())
    DisableGadget(#Load_CIF5,#False)
  EndIf
EndProcedure

Runtime Procedure LoadCIF5_RT()
  LoadCIF(CIF5.s(),#Load_CIF5)
EndProcedure

Runtime Procedure Include_Moiety()
  If ListSize(Plain_Ascii.s())
    Create_Ascii()
    Create_Markdown()
    Create_LaTeX()
    Create_RTF()
  EndIf
EndProcedure

Runtime Procedure Include_T()
  If ListSize(Plain_Ascii.s())
    Create_Ascii()
    Create_Markdown()
    Create_LaTeX()
    Create_RTF()
  EndIf
EndProcedure

Runtime Procedure Switch_SI_Units()
  If ListSize(Plain_Ascii.s())
    Create_Ascii()
    Create_Markdown()
    Create_LaTeX()
    Create_RTF()
  EndIf
EndProcedure

Runtime Procedure A4_Orientation()
  If ListSize(Plain_Ascii.s())
    Create_LaTeX()
    Create_RTF()
  EndIf
EndProcedure

Runtime Procedure Copy_Plain()
  Protected Plain_Text.s
  If ListSize(Plain_Ascii.s())
    ForEach Plain_Ascii.s()
      Plain_Text.s = Plain_Text.s + Trim(Plain_Ascii.s()) + #CRLF$
    Next
    SetClipboardText(Plain_Text.s)
  EndIf
  
EndProcedure

Runtime Procedure Copy_MD()
  Protected MD_Text.s
  If ListSize(MD_Ascii.s())
    ForEach MD_Ascii.s()
      MD_Text.s = MD_Text.s + Trim(MD_Ascii.s()) + #CRLF$
    Next
    SetClipboardText(MD_Text.s)
  EndIf
  
EndProcedure

Runtime Procedure Copy_LaTeX()
  Protected LaTeX_Text.s
  If ListSize(LaTeX.s())
    ForEach LaTeX.s()
      LaTeX_Text.s = LaTeX_Text.s + Trim(LaTeX.s()) + #CRLF$
    Next
    SetClipboardText(LaTeX_Text.s)
  EndIf
  
EndProcedure

Runtime Procedure Copy_RTF()
  Protected RTF_Text.s
  If ListSize(RTF.s())
    ForEach RTF.s()
      RTF_Text.s=RTF_Text.s + RTF.s()
    Next
    CopyRichTextToClipboard(RTF_Text.s)
  EndIf
EndProcedure

Procedure.i CopyRichTextToClipboard(rtf.s)
  CompilerSelect #PB_Compiler_OS 
    CompilerCase #PB_OS_Windows
      Protected format.i
      Protected *globalMemory
      Protected *lock
      Protected result.i
      
      format = RegisterClipboardFormat_("Rich Text Format")
      If Not format
        ProcedureReturn #False
      EndIf
      
      
      If Not OpenClipboard_(#Null)
        ProcedureReturn #False
      Else
        EmptyClipboard_()
        
        *globalMemory = GlobalAlloc_(#GMEM_MOVEABLE | #GMEM_DDESHARE, Len(rtf) + 1)
        If Not *globalMemory
          ProcedureReturn #False
        EndIf
        
        *lock = GlobalLock_(*globalMemory)
        If Not *lock
          GlobalFree_(*globalMemory)
          ProcedureReturn #False
        EndIf
        
        PokeS(*lock, rtf, -1, #PB_Ascii) ; Text in ASCII umwandeln (falls Unicode verwendet wird) und schreiben.
        GlobalUnlock_(*globalMemory)
        
        result = SetClipboardData_(format, *globalMemory)
        
        GlobalFree_(*globalMemory)
        CloseClipboard_()
        
        ProcedureReturn result
      EndIf
      
      ProcedureReturn #False
    CompilerCase #PB_OS_Linux
      Protected *mem_rtf
      ;*mem_rtf=AllocateMemory(StringByteLength(rtf) + SizeOf(Character), #PB_Ascii)
      *mem_rtf=AllocateMemory(StringByteLength(rtf) + SizeOf(Character))
      PokeS(*mem_rtf,rtf.s,-1,#PB_Ascii)
      gtk_clipboard_set_with_data_(clipboard,targets(),n_targets,@get_func(),#Null,*mem_rtf)
      gtk_clipboard_set_can_store_(clipboard,targets(),n_targets) ;clipboard nach programmende erhalten
      gtk_clipboard_store_(clipboard) ;clipboard nach programmende erhalten
    CompilerDefault
      MessageRequester("Sorry!", "This feature is available only in Windows and Linux.", #PB_MessageRequester_Ok | #PB_MessageRequester_Error)
  CompilerEndSelect
EndProcedure  

Runtime Procedure Save_RTF()
  Save_File("RTF")
EndProcedure

Runtime Procedure Save_LaTeX()
  Save_File("LaTeX")
EndProcedure

Runtime Procedure Save_Ascii()
  Save_File("Ascii")
EndProcedure

Runtime Procedure Save_MD()
  Save_File("MD")
EndProcedure

Procedure Save_File(Type.s)
  Protected Filename.s
  Protected Result
  Protected NewList SaveFile.s()
  
  Select Type.s
    Case "RTF"
      Filename.s=SaveFileRequester("Save Table", "table.rtf","RTF (*.rtf) |*.rtf",0)
      CopyList(RTF.s(),SaveFile.s())
    Case "LaTeX"
      Filename.s=SaveFileRequester("Save Table", "table.tex","TEX (*.tex) |*.tex",0)
      CopyList(LaTeX.s(),SaveFile.s())
    Case "Ascii"
      Filename.s=SaveFileRequester("Save Table", "table.txt","TXT (*.txt) |*.txt",0)
      CopyList(Plain_Ascii.s(),SaveFile.s())
    Case "MD"
      Filename.s=SaveFileRequester("Save Table", "table.md","MD (*.md) |*.md",0)
      CopyList(MD_Ascii.s(),SaveFile.s())
  EndSelect
    
  If ReadFile(0, Filename.s)   
    Result=MessageRequester("Warning!", "Overwrite File?", #PB_MessageRequester_YesNo | #PB_MessageRequester_Info)
    CloseFile(0)
  EndIf
  If Result=#PB_MessageRequester_Yes 
    If ListSize(SaveFile.s())
      If Filename.s
        If CreateFile(0, Filename.s) 
          If Type.s="RTF"
            ForEach SaveFile.s()
              WriteStringN(0,SaveFile.s(),#PB_Ascii)
            Next
            CloseFile(0)
          Else
            ForEach SaveFile.s()
              WriteStringN(0,SaveFile.s())
            Next
            CloseFile(0)
          EndIf
        Else
          MessageRequester("Error!", "File not found.", #PB_MessageRequester_Ok | #PB_MessageRequester_Error)
        EndIf 
      EndIf
    Else
      MessageRequester("Error!", "Nothing to save.", #PB_MessageRequester_Ok | #PB_MessageRequester_Error)
    EndIf
  ElseIf Result=#PB_MessageRequester_No
    ;Nope
  Else
    If ListSize(SaveFile.s())
      If Filename.s
        If CreateFile(0, Filename.s) 
          If Type.s="RTF"
            ForEach SaveFile.s()
              WriteStringN(0,SaveFile.s(),#PB_Ascii)
            Next
            CloseFile(0)
          Else
            ForEach SaveFile.s()
              WriteStringN(0,SaveFile.s())
            Next
            CloseFile(0)
          EndIf
        Else
          MessageRequester("Error!", "File not found.", #PB_MessageRequester_Ok | #PB_MessageRequester_Error)
        EndIf 
      EndIf
    Else
      MessageRequester("Error!", "Nothing to save.", #PB_MessageRequester_Ok | #PB_MessageRequester_Error)
    EndIf
  EndIf
  
EndProcedure

Runtime Procedure Clear_All()
  ClearList(CIF1.s())
  ClearList(CIF2.s())
  ClearList(CIF3.s())
  ClearList(CIF4.s())
  ClearList(CIF5.s())
  ClearList(Sum_Formula_1.Summenformel())
  ClearList(Sum_Formula_2.Summenformel())
  ClearList(Sum_Formula_3.Summenformel())
  ClearList(Sum_Formula_4.Summenformel())
  ClearList(Sum_Formula_5.Summenformel())
  ClearList(Moiety_Formula_1.Moietyformel())
  ClearList(Moiety_Formula_2.Moietyformel())
  ClearList(Moiety_Formula_3.Moietyformel())
  ClearList(Moiety_Formula_4.Moietyformel())
  ClearList(Moiety_Formula_5.Moietyformel())
  ClearList(Plain_Ascii.s())
  ClearList(MD_Ascii.s())
  ClearList(LaTeX.s())
  ClearList(RTF.s())
  ClearMap(CIF_Items_1.s())
  ClearMap(CIF_Items_2.s())
  ClearMap(CIF_Items_3.s())
  ClearMap(CIF_Items_4.s())
  ClearMap(CIF_Items_5.s())
  SetGadgetText(#Load_CIF1,"Load CIF 1")
  SetGadgetText(#Load_CIF2,"Load CIF 2")
  SetGadgetText(#Load_CIF3,"Load CIF 3")
  SetGadgetText(#Load_CIF4,"Load CIF 4")
  SetGadgetText(#Load_CIF5,"Load CIF 5")
  DisableGadget(#Load_CIF2,#True)
  DisableGadget(#Load_CIF3,#True)
  DisableGadget(#Load_CIF4,#True)
  DisableGadget(#Load_CIF5,#True)
  DisableGadget(#Copy_Plain,#True)
  DisableGadget(#Copy_MD,#True)
  DisableGadget(#Copy_LaTeX,#True)
  DisableGadget(#Copy_RTF,#True)
  DisableGadget(#Save_Plain,#True)
  DisableGadget(#Save_MD,#True)
  DisableGadget(#Save_LaTeX,#True)
  DisableGadget(#Save_RTF,#True)
  SetGadgetState(#A4_Auto, 1) 
  ClearGadgetItems(#Editor)
  Name_of_Structure_1.s = ""
  Name_of_Structure_2.s = ""
  Name_of_Structure_3.s = ""
  Name_of_Structure_4.s = ""
  Name_of_Structure_5.s = ""
EndProcedure

Runtime Procedure Help()
  If OpenXMLDialog(#Dialog, #Xml, "Help_Me")
    SetGadgetText(#Editor_Help, PeekS(?Help_Text,-1, #PB_UTF8))
  Else  
    MessageRequester("Dialog error!", "Dialog error: " + DialogError(#Dialog), #PB_MessageRequester_Ok | #PB_MessageRequester_Error)
  EndIf
EndProcedure

Runtime Procedure Close_Help()
  CloseWindow(#Help_Window)
EndProcedure

Runtime Procedure About()
  If OpenXMLDialog(#Dialog, #Xml, "About_Me")
    SetGadgetText(#Editor_About, PeekS(?License_Text,-1, #PB_UTF8))
  Else  
    MessageRequester("Dialog error!", "Dialog error: " + DialogError(#Dialog), #PB_MessageRequester_Ok | #PB_MessageRequester_Error)
  EndIf
EndProcedure

Runtime Procedure Close_About()
  CloseWindow(#About_Window)
EndProcedure

Runtime Procedure Exit()
  End
EndProcedure

Procedure LoadCIF(List CIF.s(),Gadget.i)
  
  Protected Filename.s
  
  Filename.s=OpenFileRequester("Open CIF", "*.cif","CIF (*.cif) |*.cif",0)
  If Filename.s
    If ReadFile(0, Filename.s)  
      ClearList(CIF.s())
      While Eof(0) = 0         ;CIF wirs zeilwenweise in Liste eingelesen  
        AddElement(CIF.s())
        CIF.s()=ReadString(0)
        If FindString(CIF.s(),"_refine_diff_density_rms")
          Break
        EndIf
      Wend
      CloseFile(0) 
      SetGadgetText(Gadget.i,GetFilePart(Filename.s,#PB_FileSystem_NoExtension))
      Get_Name_of_Structure(CIF.s(),Gadget.i)
      Get_Sum_Formula(CIF.s(),Gadget.i)
      Get_Moiety_Formula(CIF.s(),Gadget.i)
      Extract_Items_from_CIF(ItemsToExtract.s(),CIF.s(),Gadget.i)
      Create_Ascii()
      Create_Markdown()
      Create_LaTeX()
      Create_RTF()
    Else
      MessageRequester("Information","Could not open the CIF!", #PB_MessageRequester_Ok | #PB_MessageRequester_Error)
    EndIf
  EndIf 

EndProcedure

Procedure Get_Name_of_Structure(List CIF.s(),Gadget.i)
  
  Protected Name_of_Structure.s
  
  ForEach CIF.s()
    If FindString(CIF.s(),"loop_") 
      Break
    ElseIf FindString(CIF.s(),"data_")
      Name_of_Structure.s=RemoveString(CIF.s(),"data_")
    EndIf

  Next
  If Name_of_Structure.s = "" 
    MessageRequester("Information","Could not find 'data_' item! File can not be processed!", #PB_MessageRequester_Ok | #PB_MessageRequester_Error)
  EndIf
  
  Select Gadget.i
    Case #Load_CIF1
      Name_of_Structure_1.s=Name_of_Structure.s
    Case #Load_CIF2
      Name_of_Structure_2.s=Name_of_Structure.s
    Case #Load_CIF3
      Name_of_Structure_3.s=Name_of_Structure.s
    Case #Load_CIF4
      Name_of_Structure_4.s=Name_of_Structure.s
    Case #Load_CIF5
      Name_of_Structure_5.s=Name_of_Structure.s
  EndSelect

EndProcedure

Procedure Get_Sum_Formula(List CIF.s(),Gadget.i)
  
  Protected Summenformel_Zeile.s
  Protected Index_Start.i
  Protected Index_End.i
  Protected i.i
  Protected NewList Sum_Formula.Summenformel()
  
  ForEach CIF.s()                                   ;Begrenzung 
    If FindString(CIF.s(),"_chemical_formula_sum") 
      Index_Start = ListIndex(CIF.s())
    EndIf
    If FindString(CIF.s(),"chemical_formula_weight") 
      Index_End = ListIndex(CIF.s())
      Break
    EndIf
  Next
  
  For i = Index_Start To Index_End-1
    
    SelectElement(CIF.s(),i)
    Summenformel_Zeile.s=CIF.s()
    Summenformel_Zeile.s=RemoveString(CIF.s(),"_chemical_formula_sum")
    
    If CreateRegularExpression(0,"[A-Z][a-z]?[0-9.]{0,}")
      If ExamineRegularExpression(0,Summenformel_Zeile.s)
        While NextRegularExpressionMatch(0)
          AddElement(Sum_Formula())
          Sum_Formula()\Alles=RegularExpressionMatchString(0)
        Wend
      EndIf
    Else
      MessageRequester("Error",RegularExpressionError())
    EndIf
    FreeRegularExpression(0)
    
    ForEach Sum_Formula()
      If CreateRegularExpression(0,"[A-Z][a-z]?")
        If ExamineRegularExpression(0,Sum_Formula()\Alles)
          While NextRegularExpressionMatch(0)
            Sum_Formula()\Elemente=RegularExpressionMatchString(0)
          Wend
        EndIf
      Else
        MessageRequester("Error",RegularExpressionError())
      EndIf
      FreeRegularExpression(0)
    Next
    
    ForEach Sum_Formula()
      If CreateRegularExpression(0,"[0-9.]{0,}")
        If ExamineRegularExpression(0,Sum_Formula()\Alles)
          While NextRegularExpressionMatch(0)
            Sum_Formula()\Anzahl=RegularExpressionMatchString(0)
          Wend
        EndIf
      Else
        MessageRequester("Error",RegularExpressionError())
      EndIf
      FreeRegularExpression(0)
    Next
    
  Next
  
  Select Gadget.i
    Case #Load_CIF1
      If ListSize(Sum_Formula())
        CopyList(Sum_Formula.Summenformel(),Sum_Formula_1.Summenformel())
      EndIf
    Case #Load_CIF2
      If ListSize(Sum_Formula())
        CopyList(Sum_Formula.Summenformel(),Sum_Formula_2.Summenformel())
      EndIf
    Case #Load_CIF3
      If ListSize(Sum_Formula())
        CopyList(Sum_Formula.Summenformel(),Sum_Formula_3.Summenformel())
      EndIf
    Case #Load_CIF4
      If ListSize(Sum_Formula())
        CopyList(Sum_Formula.Summenformel(),Sum_Formula_4.Summenformel())
      EndIf
    Case #Load_CIF5
      If ListSize(Sum_Formula())
        CopyList(Sum_Formula.Summenformel(),Sum_Formula_5.Summenformel())
      EndIf
  EndSelect

EndProcedure

Procedure Get_Moiety_Formula(List CIF.s(),Gadget.i)

  Protected Moietyformel_Zeile.s
  Protected Index_Start.i
  Protected Index_End.i
  Protected i.i
  Protected NewList Moiety_Formula.Moietyformel()

  ForEach CIF.s()                                   ;Begrenzung 
    If FindString(CIF.s(),"chemical_formula_moiety") 
      Index_Start = ListIndex(CIF.s())
    EndIf
    If FindString(CIF.s(),"chemical_formula_sum") 
      Index_End = ListIndex(CIF.s())
      Break
    EndIf
  Next
  
  For i = Index_Start To Index_End-1
    
    SelectElement(CIF.s(),i)
    Moietyformel_Zeile.s=CIF.s()
    Moietyformel_Zeile.s=RemoveString(CIF.s(),"_chemical_formula_moiety")
    
    If CreateRegularExpression(0,"[0-9.]{0,}\s*\(?[A-Z][a-z]?[0-9.]{0,}[\s]{0,}[-+]?[,]?[0-9]{0,}[-+]?[,]?[\)]?[,]?")
      If ExamineRegularExpression(0,Moietyformel_Zeile.s)
        While NextRegularExpressionMatch(0)
          AddElement(Moiety_Formula())
          Moiety_Formula()\Alles=RegularExpressionMatchString(0)
        Wend
      EndIf
    Else
      MessageRequester("Error",RegularExpressionError())
    EndIf
    FreeRegularExpression(0)
    
    ForEach Moiety_Formula()
      If CreateRegularExpression(0,"[A-Z][a-z]?")
        If ExamineRegularExpression(0,Moiety_Formula()\Alles)
          While NextRegularExpressionMatch(0)
            Moiety_Formula()\Elemente=RegularExpressionMatchString(0)
          Wend
        EndIf
      Else
        MessageRequester("Error",RegularExpressionError())
      EndIf
      FreeRegularExpression(0)
    Next
    
    ForEach Moiety_Formula()
      If CreateRegularExpression(0,"[A-Z][a-z]?[0-9]{0,}[.]?[0-9]{1,}")
        If ExamineRegularExpression(0,Moiety_Formula()\Alles)
          While NextRegularExpressionMatch(0)
            Moiety_Formula()\Element_u_Anzahl=RegularExpressionMatchString(0)
          Wend
        EndIf
      Else
        MessageRequester("Error",RegularExpressionError())
      EndIf
      FreeRegularExpression(0)
    Next
    
    ForEach Moiety_Formula()
      If CreateRegularExpression(0,"[0-9.]{0,}")
        If ExamineRegularExpression(0,Moiety_Formula()\Element_u_Anzahl)
          While NextRegularExpressionMatch(0)
            Moiety_Formula()\Anzahl=RegularExpressionMatchString(0)
          Wend
        EndIf
      Else
        MessageRequester("Error",RegularExpressionError())
      EndIf
      FreeRegularExpression(0)
    Next
    
    ForEach Moiety_Formula()
      If CreateRegularExpression(0,"[,]")
        If ExamineRegularExpression(0,Moiety_Formula()\Alles)
          While NextRegularExpressionMatch(0)
            Moiety_Formula()\Trennung=RegularExpressionMatchString(0) + Space(1)
          Wend
        EndIf
      Else
        MessageRequester("Error",RegularExpressionError())
      EndIf
      FreeRegularExpression(0)
    Next
    
    ForEach Moiety_Formula()
      If CreateRegularExpression(0,"[0-9]*[+-]")
        If ExamineRegularExpression(0,Moiety_Formula()\Alles)
          While NextRegularExpressionMatch(0)
            Moiety_Formula()\Ladung=RegularExpressionMatchString(0)
          Wend
        EndIf
      Else
        MessageRequester("Error",RegularExpressionError())
      EndIf
      FreeRegularExpression(0)
    Next 
    
    ForEach Moiety_Formula()
      If CreateRegularExpression(0,"[0-9.]{0,}?\s*\(")
        If ExamineRegularExpression(0,Moiety_Formula()\Alles)
          While NextRegularExpressionMatch(0)
            Moiety_Formula()\Aufklammer=LTrim(RegularExpressionMatchString(0))
          Wend
        EndIf
      Else
        MessageRequester("Error",RegularExpressionError())
      EndIf
      FreeRegularExpression(0)
    Next 
    
    ForEach Moiety_Formula()
      If CreateRegularExpression(0,"\)")
        If ExamineRegularExpression(0,Moiety_Formula()\Alles)
          While NextRegularExpressionMatch(0)
            Moiety_Formula()\Zuklammer=RegularExpressionMatchString(0)
          Wend
        EndIf
      Else
        MessageRequester("Error",RegularExpressionError())
      EndIf
      FreeRegularExpression(0)
    Next 
  Next
  
  Select Gadget.i
    Case #Load_CIF1
      ClearList(Moiety_Formula_1.Moietyformel())
      If ListSize(Moiety_Formula())
        CopyList(Moiety_Formula.Moietyformel(),Moiety_Formula_1.Moietyformel())
      Else
        AddElement(Moiety_Formula_1.Moietyformel())
        Moiety_Formula_1.Moietyformel()\Elemente="-"
      EndIf
    Case #Load_CIF2
      ClearList(Moiety_Formula_2.Moietyformel())
      If ListSize(Moiety_Formula())
        CopyList(Moiety_Formula.Moietyformel(),Moiety_Formula_2.Moietyformel())
      Else
        AddElement(Moiety_Formula_2.Moietyformel())
        Moiety_Formula_2.Moietyformel()\Elemente="-"
      EndIf
    Case #Load_CIF3
      ClearList(Moiety_Formula_3.Moietyformel())
      If ListSize(Moiety_Formula())
        CopyList(Moiety_Formula.Moietyformel(),Moiety_Formula_3.Moietyformel())
      Else
        AddElement(Moiety_Formula_3.Moietyformel())
        Moiety_Formula_3.Moietyformel()\Elemente="-"
      EndIf
    Case #Load_CIF4
      ClearList(Moiety_Formula_4.Moietyformel())
      If ListSize(Moiety_Formula())
        CopyList(Moiety_Formula.Moietyformel(),Moiety_Formula_4.Moietyformel())
      Else
        AddElement(Moiety_Formula_4.Moietyformel())
        Moiety_Formula_4.Moietyformel()\Elemente="-"
      EndIf
    Case #Load_CIF5
      ClearList(Moiety_Formula_5.Moietyformel())
      If ListSize(Moiety_Formula())
        CopyList(Moiety_Formula.Moietyformel(),Moiety_Formula_5.Moietyformel())
      Else
        AddElement(Moiety_Formula_5.Moietyformel())
        Moiety_Formula_5.Moietyformel()\Elemente="-"
      EndIf
  EndSelect
  
EndProcedure

Procedure Extract_Items_from_CIF(List ItemsToExtract.s(),List CIF.s(),Gadget.i)
  
  Protected NewMap CIF_Items.s()
  
  ForEach CIF.s()
    ForEach ItemsToExtract.s()
      If ItemsToExtract.s() = StringField(Trim(CIF.s()),1," ")
        CIF_Items.s(ItemsToExtract.s()) = Trim(RemoveString(CIF.s(),StringField(Trim(CIF.s()),1," ")))
      EndIf
    Next
  Next
  
  Select Gadget.i
    Case #Load_CIF1
      If MapSize(CIF_Items.s())
        CopyMap(CIF_Items.s(),CIF_Items_1.s())
      EndIf
    Case #Load_CIF2
      If MapSize(CIF_Items.s())
        CopyMap(CIF_Items.s(),CIF_Items_2.s())
      EndIf
    Case #Load_CIF3
      If MapSize(CIF_Items.s())
        CopyMap(CIF_Items.s(),CIF_Items_3.s())
      EndIf
    Case #Load_CIF4
      If MapSize(CIF_Items.s())
        CopyMap(CIF_Items.s(),CIF_Items_4.s())
      EndIf
    Case #Load_CIF5
      If MapSize(CIF_Items.s())
        CopyMap(CIF_Items.s(),CIF_Items_5.s())
      EndIf
  EndSelect
  
;   ForEach CIF_Items_1.s()
;     Debug MapKey(CIF_Items_1.s())
;     Debug CIF_Items_1.s()
;   Next

EndProcedure

Procedure Items_to_extract_from_CIF()
  
  AddElement(ItemsToExtract()) : ItemsToExtract()="_chemical_formula_weight"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_space_group_crystal_system"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_space_group_IT_number"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_space_group_name_H-M_alt"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_symmetry_cell_setting"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_symmetry_space_group_name_H-M"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_cell_length_a"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_cell_length_b"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_cell_length_c"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_cell_angle_alpha"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_cell_angle_beta"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_cell_angle_gamma"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_cell_volume"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_cell_formula_units_Z"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_exptl_crystal_description"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_exptl_crystal_size_max"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_exptl_crystal_size_mid"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_exptl_crystal_size_min"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_exptl_absorpt_coefficient_mu"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_exptl_crystal_density_diffrn"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_exptl_crystal_F_000"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_exptl_absorpt_correction_T_min"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_exptl_absorpt_correction_T_max"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_diffrn_ambient_temperature"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_diffrn_reflns_number"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_diffrn_reflns_av_R_equivalents"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_diffrn_reflns_limit_h_min"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_diffrn_reflns_limit_h_max"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_diffrn_reflns_limit_k_min"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_diffrn_reflns_limit_k_max"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_diffrn_reflns_limit_l_min"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_diffrn_reflns_limit_l_max"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_diffrn_reflns_theta_min"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_diffrn_reflns_theta_max"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_reflns_number_total"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_reflns_number_gt"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_refine_ls_number_reflns"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_refine_ls_number_parameters"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_refine_ls_number_restraints"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_refine_ls_R_factor_all"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_refine_ls_R_factor_gt"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_refine_ls_wR_factor_ref"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_refine_ls_wR_factor_gt"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_refine_ls_goodness_of_fit_ref"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_refine_diff_density_max"
  AddElement(ItemsToExtract()) : ItemsToExtract()="_refine_diff_density_min"
  
EndProcedure

Procedure Create_Ascii()
  
  ClearList(Plain_Ascii.s())
  ClearGadgetItems(#Editor)
  
  Protected SF_1.s, SF_2.s, SF_3.s, SF_4.s, SF_5.s
  Protected MF_1.s, MF_2.s, MF_3.s, MF_4.s, MF_5.s  
  Protected CS_1.s, CS_2.s, CS_3.s, CS_4.s, CS_5.s
  Protected SG_1.s, SG_2.s, SG_3.s, SG_4.s, SG_5.s
  Protected TM_1.s, TM_2.s, TM_3.s, TM_4.s, TM_5.s
  Protected TR_1.s, TR_2.s, TR_3.s, TR_4.s, TR_5.s
  Protected HR_1.s, HR_2.s, HR_3.s, HR_4.s, HR_5.s
  Protected UR_1.s, UR_2.s, UR_3.s, UR_4.s, UR_5.s
  Protected DRP_1.s, DRP_2.s, DRP_3.s, DRP_4.s, DRP_5.s
  Protected R12_1.s, R12_2.s, R12_3.s, R12_4.s, R12_5.s
  Protected R12A_1.s, R12A_2.s, R12A_3.s, R12A_4.s, R12A_5.s
  Protected RE_1.s, RE_2.s, RE_3.s, RE_4.s, RE_5.s
  Protected Caption.s
  Protected NewMap Unit.Units()
  Protected Is_Name_of_Structure_1.b=#False, Is_Name_of_Structure_2.b=#False, Is_Name_of_Structure_3.b=#False, Is_Name_of_Structure_4.b=#False, Is_Name_of_Structure_5.b=#False
  Protected Max_Char_Column.i
  Protected Number_of_Spaces_to_Insert.i
  Protected Zeile.i
  Protected i.i
  
  If GetGadgetState(#SI_Units)=#PB_Checkbox_Checked  
    CopyMap(SI_Units(),Unit())
  Else
    CopyMap(Units(),Unit())
  EndIf
  
  If ListSize(Sum_Formula_1.Summenformel())
    ForEach Sum_Formula_1.Summenformel()
      SF_1.s = SF_1.s + Sum_Formula_1.Summenformel()\Elemente + Sum_Formula_1.Summenformel()\Anzahl + " "
    Next
  EndIf
  
  If ListSize(Sum_Formula_2.Summenformel())
    ForEach Sum_Formula_2.Summenformel()
      SF_2.s = SF_2.s + Sum_Formula_2.Summenformel()\Elemente + Sum_Formula_2.Summenformel()\Anzahl + " "
    Next
  EndIf
  
  If ListSize(Sum_Formula_3.Summenformel())
    ForEach Sum_Formula_3.Summenformel()
      SF_3.s = SF_3.s + Sum_Formula_3.Summenformel()\Elemente + Sum_Formula_3.Summenformel()\Anzahl + " "
    Next
  EndIf
  
  If ListSize(Sum_Formula_4.Summenformel())
    ForEach Sum_Formula_4.Summenformel()
      SF_4.s = SF_4.s + Sum_Formula_4.Summenformel()\Elemente + Sum_Formula_4.Summenformel()\Anzahl + " "
    Next
  EndIf
  
  If ListSize(Sum_Formula_5.Summenformel())
    ForEach Sum_Formula_5.Summenformel()
      SF_5.s = SF_5.s + Sum_Formula_5.Summenformel()\Elemente + Sum_Formula_5.Summenformel()\Anzahl + " "
    Next
  EndIf

  If ListSize(Moiety_Formula_1.Moietyformel())
    ForEach Moiety_Formula_1.Moietyformel()
      MF_1.s = MF_1.s + Moiety_Formula_1.Moietyformel()\Aufklammer + Moiety_Formula_1.Moietyformel()\Elemente + Moiety_Formula_1.Moietyformel()\Anzahl + " " + Moiety_Formula_1.Moietyformel()\Ladung + Moiety_Formula_1.Moietyformel()\Zuklammer + Moiety_Formula_1.Moietyformel()\Trennung
      MF_1.s = ReplaceString(MF_1.s," )", ")")
    Next
  EndIf  
  
  If ListSize(Moiety_Formula_2.Moietyformel())
    ForEach Moiety_Formula_2.Moietyformel()
      MF_2.s = MF_2.s + Moiety_Formula_2.Moietyformel()\Aufklammer + Moiety_Formula_2.Moietyformel()\Elemente + Moiety_Formula_2.Moietyformel()\Anzahl + " " + Moiety_Formula_2.Moietyformel()\Ladung + Moiety_Formula_2.Moietyformel()\Zuklammer + Moiety_Formula_2.Moietyformel()\Trennung
      MF_2.s = ReplaceString(MF_2.s," )", ")")
    Next
  EndIf  
  
  If ListSize(Moiety_Formula_3.Moietyformel())
    ForEach Moiety_Formula_3.Moietyformel()
      MF_3.s = MF_3.s + Moiety_Formula_3.Moietyformel()\Aufklammer + Moiety_Formula_3.Moietyformel()\Elemente + Moiety_Formula_3.Moietyformel()\Anzahl + " " + Moiety_Formula_3.Moietyformel()\Ladung + Moiety_Formula_3.Moietyformel()\Zuklammer + Moiety_Formula_3.Moietyformel()\Trennung
      MF_3.s = ReplaceString(MF_3.s," )", ")")
    Next
  EndIf 
  
  If ListSize(Moiety_Formula_4.Moietyformel())
    ForEach Moiety_Formula_4.Moietyformel()
      MF_4.s = MF_4.s+ Moiety_Formula_4.Moietyformel()\Aufklammer + Moiety_Formula_4.Moietyformel()\Elemente + Moiety_Formula_4.Moietyformel()\Anzahl + " " + Moiety_Formula_4.Moietyformel()\Ladung + Moiety_Formula_4.Moietyformel()\Zuklammer + Moiety_Formula_4.Moietyformel()\Trennung
      MF_4.s = ReplaceString(MF_4.s," )", ")")
    Next
  EndIf  
  
  If ListSize(Moiety_Formula_5.Moietyformel())
    ForEach Moiety_Formula_5.Moietyformel()
      MF_5.s = MF_5.s + Moiety_Formula_5.Moietyformel()\Aufklammer + Moiety_Formula_5.Moietyformel()\Elemente + Moiety_Formula_5.Moietyformel()\Anzahl + " " + Moiety_Formula_5.Moietyformel()\Ladung + Moiety_Formula_5.Moietyformel()\Zuklammer + Moiety_Formula_5.Moietyformel()\Trennung
      MF_5.s = ReplaceString(MF_5.s," )", ")")
    Next
  EndIf 
  
  CS_1.s = CIF_Items_1.s("_exptl_crystal_size_max") + " x " + CIF_Items_1.s("_exptl_crystal_size_mid") + " x " + CIF_Items_1.s("_exptl_crystal_size_min") 
  CS_2.s = CIF_Items_2.s("_exptl_crystal_size_max") + " x " + CIF_Items_2.s("_exptl_crystal_size_mid") + " x " + CIF_Items_2.s("_exptl_crystal_size_min") 
  CS_3.s = CIF_Items_3.s("_exptl_crystal_size_max") + " x " + CIF_Items_3.s("_exptl_crystal_size_mid") + " x " + CIF_Items_3.s("_exptl_crystal_size_min")
  CS_4.s = CIF_Items_4.s("_exptl_crystal_size_max") + " x " + CIF_Items_4.s("_exptl_crystal_size_mid") + " x " + CIF_Items_4.s("_exptl_crystal_size_min")
  CS_5.s = CIF_Items_5.s("_exptl_crystal_size_max") + " x " + CIF_Items_5.s("_exptl_crystal_size_mid") + " x " + CIF_Items_5.s("_exptl_crystal_size_min")
  
  If CS_1.s=" x  x " : CS_1.s="" : EndIf
  If CS_2.s=" x  x " : CS_2.s="" : EndIf
  If CS_3.s=" x  x " : CS_3.s="" : EndIf
  If CS_4.s=" x  x " : CS_4.s="" : EndIf
  If CS_5.s=" x  x " : CS_5.s="" : EndIf
  
  SG_1.s = RemoveString(Trim(CIF_Items_1.s("_space_group_name_H-M_alt"),"'")," ") + " (No. " + CIF_Items_1.s("_space_group_IT_number") + ")" + RemoveString(Trim(CIF_Items_1.s("_symmetry_space_group_name_H-M"),"'")," ")
  SG_2.s = RemoveString(Trim(CIF_Items_2.s("_space_group_name_H-M_alt"),"'")," ") + " (No. " + CIF_Items_2.s("_space_group_IT_number") + ")" + RemoveString(Trim(CIF_Items_2.s("_symmetry_space_group_name_H-M"),"'")," ")
  SG_3.s = RemoveString(Trim(CIF_Items_3.s("_space_group_name_H-M_alt"),"'")," ") + " (No. " + CIF_Items_3.s("_space_group_IT_number") + ")" + RemoveString(Trim(CIF_Items_3.s("_symmetry_space_group_name_H-M"),"'")," ")
  SG_4.s = RemoveString(Trim(CIF_Items_4.s("_space_group_name_H-M_alt"),"'")," ") + " (No. " + CIF_Items_4.s("_space_group_IT_number") + ")" + RemoveString(Trim(CIF_Items_4.s("_symmetry_space_group_name_H-M"),"'")," ")
  SG_5.s = RemoveString(Trim(CIF_Items_5.s("_space_group_name_H-M_alt"),"'")," ") + " (No. " + CIF_Items_5.s("_space_group_IT_number") + ")" + RemoveString(Trim(CIF_Items_5.s("_symmetry_space_group_name_H-M"),"'")," ")
  
  SG_1.s = RemoveString(SG_1.s," (No. " + ")")
  SG_2.s = RemoveString(SG_2.s," (No. " + ")")
  SG_3.s = RemoveString(SG_3.s," (No. " + ")")
  SG_4.s = RemoveString(SG_4.s," (No. " + ")")
  SG_5.s = RemoveString(SG_5.s," (No. " + ")")
  
  TM_1.s = CIF_Items_1.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_1.s("_exptl_absorpt_correction_T_max")
  TM_2.s = CIF_Items_2.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_2.s("_exptl_absorpt_correction_T_max")
  TM_3.s = CIF_Items_3.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_3.s("_exptl_absorpt_correction_T_max")
  TM_4.s = CIF_Items_4.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_4.s("_exptl_absorpt_correction_T_max")
  TM_5.s = CIF_Items_5.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_5.s("_exptl_absorpt_correction_T_max")
  
  If TM_1.s=" / " : TM_1.s="" : EndIf
  If TM_2.s=" / " : TM_2.s="" : EndIf
  If TM_3.s=" / " : TM_3.s="" : EndIf
  If TM_4.s=" / " : TM_4.s="" : EndIf
  If TM_5.s=" / " : TM_5.s="" : EndIf
  
  TR_1.s = CIF_Items_1.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_1.s("_diffrn_reflns_theta_max")
  TR_2.s = CIF_Items_2.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_2.s("_diffrn_reflns_theta_max")
  TR_3.s = CIF_Items_3.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_3.s("_diffrn_reflns_theta_max")
  TR_4.s = CIF_Items_4.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_4.s("_diffrn_reflns_theta_max")
  TR_5.s = CIF_Items_5.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_5.s("_diffrn_reflns_theta_max")
  
  If TR_1.s=" - " : TR_1.s="" : EndIf
  If TR_2.s=" - " : TR_2.s="" : EndIf
  If TR_3.s=" - " : TR_3.s="" : EndIf
  If TR_4.s=" - " : TR_4.s="" : EndIf
  If TR_5.s=" - " : TR_5.s="" : EndIf
 
  HR_1.s = HKL_entry_Ascii(CIF_Items_1.s())
  HR_2.s = HKL_entry_Ascii(CIF_Items_2.s())
  HR_3.s = HKL_entry_Ascii(CIF_Items_3.s())
  HR_4.s = HKL_entry_Ascii(CIF_Items_4.s())
  HR_5.s = HKL_entry_Ascii(CIF_Items_5.s())
  
  HR_1.s = Trim(RemoveString(HR_1.s,"±,"))
  HR_2.s = Trim(RemoveString(HR_2.s,"±,"))
  HR_3.s = Trim(RemoveString(HR_3.s,"±,"))
  HR_4.s = Trim(RemoveString(HR_4.s,"±,"))
  HR_5.s = Trim(RemoveString(HR_5.s,"±,"))
  
  If HR_1.s="±" : HR_1.s="" : EndIf
  If HR_2.s="±" : HR_2.s="" : EndIf
  If HR_3.s="±" : HR_3.s="" : EndIf
  If HR_4.s="±" : HR_4.s="" : EndIf
  If HR_5.s="±" : HR_5.s="" : EndIf
  
  UR_1.s = CIF_Items_1.s("_reflns_number_total") + " [" + CIF_Items_1.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_2.s = CIF_Items_2.s("_reflns_number_total") + " [" + CIF_Items_2.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_3.s = CIF_Items_3.s("_reflns_number_total") + " [" + CIF_Items_3.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_4.s = CIF_Items_4.s("_reflns_number_total") + " [" + CIF_Items_4.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_5.s = CIF_Items_5.s("_reflns_number_total") + " [" + CIF_Items_5.s("_diffrn_reflns_av_R_equivalents") + "]"
  
  If UR_1.s=" []" : UR_1.s="" : EndIf
  If UR_2.s=" []" : UR_2.s="" : EndIf
  If UR_3.s=" []" : UR_3.s="" : EndIf
  If UR_4.s=" []" : UR_4.s="" : EndIf
  If UR_5.s=" []" : UR_5.s="" : EndIf
  
  DRP_1.s = CIF_Items_1.s("_reflns_number_total") + " / " + CIF_Items_1.s("_refine_ls_number_restraints")  + " / " + CIF_Items_1.s("_refine_ls_number_parameters")
  DRP_2.s = CIF_Items_2.s("_reflns_number_total") + " / " + CIF_Items_2.s("_refine_ls_number_restraints")  + " / " + CIF_Items_2.s("_refine_ls_number_parameters")
  DRP_3.s = CIF_Items_3.s("_reflns_number_total") + " / " + CIF_Items_3.s("_refine_ls_number_restraints")  + " / " + CIF_Items_3.s("_refine_ls_number_parameters")
  DRP_4.s = CIF_Items_4.s("_reflns_number_total") + " / " + CIF_Items_4.s("_refine_ls_number_restraints")  + " / " + CIF_Items_4.s("_refine_ls_number_parameters")
  DRP_5.s = CIF_Items_5.s("_reflns_number_total") + " / " + CIF_Items_5.s("_refine_ls_number_restraints")  + " / " + CIF_Items_5.s("_refine_ls_number_parameters")
  
  If DRP_1.s=" /  / " : DRP_1.s="" : EndIf
  If DRP_2.s=" /  / " : DRP_2.s="" : EndIf
  If DRP_3.s=" /  / " : DRP_3.s="" : EndIf
  If DRP_4.s=" /  / " : DRP_4.s="" : EndIf
  If DRP_5.s=" /  / " : DRP_5.s="" : EndIf
  
  R12_1.s = CIF_Items_1.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_1.s("_refine_ls_wR_factor_gt")
  R12_2.s = CIF_Items_2.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_2.s("_refine_ls_wR_factor_gt")
  R12_3.s = CIF_Items_3.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_3.s("_refine_ls_wR_factor_gt")
  R12_4.s = CIF_Items_4.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_4.s("_refine_ls_wR_factor_gt")
  R12_5.s = CIF_Items_5.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_5.s("_refine_ls_wR_factor_gt")
  
  If R12_1.s=" / " : R12_1.s="" : EndIf
  If R12_2.s=" / " : R12_2.s="" : EndIf
  If R12_3.s=" / " : R12_3.s="" : EndIf
  If R12_4.s=" / " : R12_4.s="" : EndIf
  If R12_5.s=" / " : R12_5.s="" : EndIf
  
  R12A_1.s = CIF_Items_1.s("_refine_ls_R_factor_all") + " / " + CIF_Items_1.s("_refine_ls_wR_factor_ref")
  R12A_2.s = CIF_Items_2.s("_refine_ls_R_factor_all") + " / " + CIF_Items_2.s("_refine_ls_wR_factor_ref")
  R12A_3.s = CIF_Items_3.s("_refine_ls_R_factor_all") + " / " + CIF_Items_3.s("_refine_ls_wR_factor_ref")
  R12A_4.s = CIF_Items_4.s("_refine_ls_R_factor_all") + " / " + CIF_Items_4.s("_refine_ls_wR_factor_ref")
  R12A_5.s = CIF_Items_5.s("_refine_ls_R_factor_all") + " / " + CIF_Items_5.s("_refine_ls_wR_factor_ref")
  
  If R12A_1.s=" / " : R12A_1.s="" : EndIf
  If R12A_2.s=" / " : R12A_2.s="" : EndIf
  If R12A_3.s=" / " : R12A_3.s="" : EndIf
  If R12A_4.s=" / " : R12A_4.s="" : EndIf
  If R12A_5.s=" / " : R12A_5.s="" : EndIf
  
  RE_1.s = CIF_Items_1.s("_refine_diff_density_min") + " / " + CIF_Items_1.s("_refine_diff_density_max")
  RE_2.s = CIF_Items_2.s("_refine_diff_density_min") + " / " + CIF_Items_2.s("_refine_diff_density_max")
  RE_3.s = CIF_Items_3.s("_refine_diff_density_min") + " / " + CIF_Items_3.s("_refine_diff_density_max")
  RE_4.s = CIF_Items_4.s("_refine_diff_density_min") + " / " + CIF_Items_4.s("_refine_diff_density_max")
  RE_5.s = CIF_Items_5.s("_refine_diff_density_min") + " / " + CIF_Items_5.s("_refine_diff_density_max")
  
  If RE_1.s=" / " : RE_1.s="" : EndIf
  If RE_2.s=" / " : RE_2.s="" : EndIf
  If RE_3.s=" / " : RE_3.s="" : EndIf
  If RE_4.s=" / " : RE_4.s="" : EndIf
  If RE_5.s=" / " : RE_5.s="" : EndIf
 
  If Name_of_Structure_1.s : Is_Name_of_Structure_1.b=#True : EndIf
  If Name_of_Structure_2.s : Is_Name_of_Structure_2.b=#True : EndIf
  If Name_of_Structure_3.s : Is_Name_of_Structure_3.b=#True : EndIf
  If Name_of_Structure_4.s : Is_Name_of_Structure_4.b=#True : EndIf
  If Name_of_Structure_5.s : Is_Name_of_Structure_5.b=#True : EndIf
  
  If Is_Name_of_Structure_1.b And Not Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "Table 1. Crystal data and refinement details for " + Name_of_Structure_1.s + "." 
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "Table 1. Crystal data and refinement details for " + Name_of_Structure_1.s + " and " + Name_of_Structure_2.s + "."
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "Table 1. Crystal data and refinement details for " + Name_of_Structure_1.s + ", " + Name_of_Structure_2.s + ", and " + Name_of_Structure_3.s + "."
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "Table 1. Crystal data and refinement details for " + Name_of_Structure_1.s + ", " + Name_of_Structure_2.s + ", " + Name_of_Structure_3.s + ", and " + Name_of_Structure_4.s + "."
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Is_Name_of_Structure_5.b
    Caption.s= "Table 1. Crystal data and refinement details for " + Name_of_Structure_1.s + ", " + Name_of_Structure_2.s + ", " + Name_of_Structure_3.s + ", " + Name_of_Structure_4.s + ", and " + Name_of_Structure_5.s + "."
  EndIf

  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = Caption.s
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "compound" + "TAB1" + Name_of_Structure_1.s + "TAB2" + Name_of_Structure_2.s + "TAB3" +Name_of_Structure_3.s + "TAB4" + Name_of_Structure_4.s + "TAB5" + Name_of_Structure_5.s
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "empirical formula" + "TAB1" + SF_1.s + "TAB2" + SF_2.s + "TAB3" + SF_3.s + "TAB4" + SF_4.s + "TAB5" + SF_5.s
  If GetGadgetState(#Include_Moiety)=#PB_Checkbox_Checked 
    AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "moiety formula" + "TAB1" + MF_1.s + "TAB2" + MF_2.s + "TAB3" + MF_3.s + "TAB4" + MF_4.s + "TAB5" + MF_5.s 
  EndIf
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "formula weight" + "TAB1" + CIF_Items_1.s("_chemical_formula_weight") + 
                                                  "TAB2" + CIF_Items_2.s("_chemical_formula_weight") +
                                                  "TAB3" + CIF_Items_3.s("_chemical_formula_weight") +
                                                  "TAB4" + CIF_Items_4.s("_chemical_formula_weight") +
                                                  "TAB5" + CIF_Items_5.s("_chemical_formula_weight") 
  If GetGadgetState(#Include_T)=#PB_Checkbox_Checked 
    AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "T " + Unit("Kel")\Unit_Asc + "TAB1" + CIF_Items_1.s("_diffrn_ambient_temperature") + 
                                                    "TAB2" + CIF_Items_2.s("_diffrn_ambient_temperature") +
                                                    "TAB3" + CIF_Items_3.s("_diffrn_ambient_temperature") +
                                                    "TAB4" + CIF_Items_4.s("_diffrn_ambient_temperature") +
                                                    "TAB5" + CIF_Items_5.s("_diffrn_ambient_temperature") 
  EndIf
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "crystal size " + Unit("Siz")\Unit_Asc + "TAB1" + CS_1.s + "TAB2" + CS_2.s + "TAB3" + CS_3.s + "TAB4" + CS_4.s + "TAB5" + CS_5.s                                            
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "crystal system" + "TAB1" + CIF_Items_1.s("_space_group_crystal_system") + CIF_Items_1.s("_symmetry_cell_setting") + 
                                                  "TAB2" + CIF_Items_2.s("_space_group_crystal_system") + CIF_Items_2.s("_symmetry_cell_setting") +
                                                  "TAB3" + CIF_Items_3.s("_space_group_crystal_system") + CIF_Items_3.s("_symmetry_cell_setting") +
                                                  "TAB4" + CIF_Items_4.s("_space_group_crystal_system") + CIF_Items_4.s("_symmetry_cell_setting") +
                                                  "TAB5" + CIF_Items_5.s("_space_group_crystal_system") + CIF_Items_5.s("_symmetry_cell_setting")
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "space group" + "TAB1" + SG_1.s + "TAB2" + SG_2.s + "TAB3" + SG_3.s + "TAB4" + SG_4.s + "TAB5" + SG_5.s 
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "a " + Unit("Ang")\Unit_Asc + "TAB1" + CIF_Items_1.s("_cell_length_a") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_length_a") +
                                                  "TAB3" + CIF_Items_3.s("_cell_length_a") +
                                                  "TAB4" + CIF_Items_4.s("_cell_length_a") +
                                                  "TAB5" + CIF_Items_5.s("_cell_length_a") 
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "b " + Unit("Ang")\Unit_Asc + "TAB1" + CIF_Items_1.s("_cell_length_b") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_length_b") +
                                                  "TAB3" + CIF_Items_3.s("_cell_length_b") +
                                                  "TAB4" + CIF_Items_4.s("_cell_length_b") +
                                                  "TAB5" + CIF_Items_5.s("_cell_length_b") 
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "c " + Unit("Ang")\Unit_Asc + "TAB1" + CIF_Items_1.s("_cell_length_c") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_length_c") +
                                                  "TAB3" + CIF_Items_3.s("_cell_length_c") +
                                                  "TAB4" + CIF_Items_4.s("_cell_length_c") +
                                                  "TAB5" + CIF_Items_5.s("_cell_length_c") 
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "α " + Unit("Deg")\Unit_Asc + "TAB1" + CIF_Items_1.s("_cell_angle_alpha") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_angle_alpha") +
                                                  "TAB3" + CIF_Items_3.s("_cell_angle_alpha") +
                                                  "TAB4" + CIF_Items_4.s("_cell_angle_alpha") +
                                                  "TAB5" + CIF_Items_5.s("_cell_angle_alpha") 
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "β " + Unit("Deg")\Unit_Asc + "TAB1" + CIF_Items_1.s("_cell_angle_beta") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_angle_beta") +
                                                  "TAB3" + CIF_Items_3.s("_cell_angle_beta") +
                                                  "TAB4" + CIF_Items_4.s("_cell_angle_beta") +
                                                  "TAB5" + CIF_Items_5.s("_cell_angle_beta")   
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "γ " + Unit("Deg")\Unit_Asc + "TAB1" + CIF_Items_1.s("_cell_angle_gamma") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_angle_gamma") +
                                                  "TAB3" + CIF_Items_3.s("_cell_angle_gamma") +
                                                  "TAB4" + CIF_Items_4.s("_cell_angle_gamma") +
                                                  "TAB5" + CIF_Items_5.s("_cell_angle_gamma") 
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "V " + Unit("Vol")\Unit_Asc + "TAB1" + CIF_Items_1.s("_cell_volume") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_volume") +
                                                  "TAB3" + CIF_Items_3.s("_cell_volume") +
                                                  "TAB4" + CIF_Items_4.s("_cell_volume") +
                                                  "TAB5" + CIF_Items_5.s("_cell_volume") 
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "Z " + "TAB1" + CIF_Items_1.s("_cell_formula_units_Z") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_formula_units_Z") +
                                                  "TAB3" + CIF_Items_3.s("_cell_formula_units_Z") +
                                                  "TAB4" + CIF_Items_4.s("_cell_formula_units_Z") +
                                                  "TAB5" + CIF_Items_5.s("_cell_formula_units_Z") 
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "ρ " + Unit("Rho")\Unit_Asc + "TAB1" + CIF_Items_1.s("_exptl_crystal_density_diffrn") + 
                                                  "TAB2" + CIF_Items_2.s("_exptl_crystal_density_diffrn") +
                                                  "TAB3" + CIF_Items_3.s("_exptl_crystal_density_diffrn") +
                                                  "TAB4" + CIF_Items_4.s("_exptl_crystal_density_diffrn") +
                                                  "TAB5" + CIF_Items_5.s("_exptl_crystal_density_diffrn") 
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "F(000)" + "TAB1" + CIF_Items_1.s("_exptl_crystal_F_000") + 
                                                  "TAB2" + CIF_Items_2.s("_exptl_crystal_F_000") +
                                                  "TAB3" + CIF_Items_3.s("_exptl_crystal_F_000") +
                                                  "TAB4" + CIF_Items_4.s("_exptl_crystal_F_000") +
                                                  "TAB5" + CIF_Items_5.s("_exptl_crystal_F_000") 
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "µ " + Unit("Abs")\Unit_Asc + "TAB1" + CIF_Items_1.s("_exptl_absorpt_coefficient_mu") + 
                                                  "TAB2" + CIF_Items_2.s("_exptl_absorpt_coefficient_mu") +
                                                  "TAB3" + CIF_Items_3.s("_exptl_absorpt_coefficient_mu") +
                                                  "TAB4" + CIF_Items_4.s("_exptl_absorpt_coefficient_mu") +
                                                  "TAB5" + CIF_Items_5.s("_exptl_absorpt_coefficient_mu")

  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "Tmin / Tmax" + "TAB1" + TM_1.s + "TAB2" + TM_2.s + "TAB3" + TM_3.s + "TAB4" + TM_4.s + "TAB5" + TM_5.s 
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "θ-range "  + Unit("Deg")\Unit_Asc + "TAB1" + TR_1.s + "TAB2" + TR_2.s + "TAB3" + TR_3.s + "TAB4" + TR_4.s + "TAB5" + TR_5.s 
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "hkl-range" + "TAB1" + HR_1.s + "TAB2" + HR_2.s + "TAB3" + HR_3.s + "TAB4" + HR_4.s + "TAB5" + HR_5.s 
  
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "measured refl." + "TAB1" + CIF_Items_1.s("_diffrn_reflns_number") + 
                                                  "TAB2" + CIF_Items_2.s("_diffrn_reflns_number") +
                                                  "TAB3" + CIF_Items_3.s("_diffrn_reflns_number") +
                                                  "TAB4" + CIF_Items_4.s("_diffrn_reflns_number") +
                                                  "TAB5" + CIF_Items_5.s("_diffrn_reflns_number")
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "unique refl. [Rint]" + "TAB1" + UR_1.s + "TAB2" + UR_2.s + "TAB3" + UR_3.s + "TAB4" + UR_4.s + "TAB5" + UR_5.s
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "obs. refl. (I > 2σ(I))" + "TAB1" + CIF_Items_1.s("_reflns_number_gt") + 
                                                  "TAB2" + CIF_Items_2.s("_reflns_number_gt") +
                                                  "TAB3" + CIF_Items_3.s("_reflns_number_gt") +
                                                  "TAB4" + CIF_Items_4.s("_reflns_number_gt") +
                                                  "TAB5" + CIF_Items_5.s("_reflns_number_gt")
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "data / restr. / param." + "TAB1" + DRP_1.s + "TAB2" + DRP_2.s + "TAB3" + DRP_3.s + "TAB4" + DRP_4.s + "TAB5" + DRP_5.s
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "goodness-of-fit (F²)" + "TAB1" + CIF_Items_1.s("_refine_ls_goodness_of_fit_ref") + 
                                                  "TAB2" + CIF_Items_2.s("_refine_ls_goodness_of_fit_ref") +
                                                  "TAB3" + CIF_Items_3.s("_refine_ls_goodness_of_fit_ref") +
                                                  "TAB4" + CIF_Items_4.s("_refine_ls_goodness_of_fit_ref") +
                                                  "TAB5" + CIF_Items_5.s("_refine_ls_goodness_of_fit_ref")
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "R1, wR2 (I > 2σ(I))" + "TAB1" + R12_1.s + "TAB2" + R12_2.s + "TAB3" + R12_3.s + "TAB4" + R12_4.s + "TAB5" + R12_5.s
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "R1, wR2 (all data)" + "TAB1" + R12A_1.s + "TAB2" + R12A_2.s + "TAB3" + R12A_3.s + "TAB4" + R12A_4.s + "TAB5" + R12A_5.s
  AddElement(Plain_Ascii.s()) : Plain_Ascii.s() = "res. el. dens. "  + Unit("Red")\Unit_Asc + "TAB1" + RE_1.s + "TAB2" + RE_2.s + "TAB3" + RE_3.s + "TAB4" + RE_4.s + "TAB5" + RE_5.s
  
  ForEach Plain_Ascii.s()
    If FindString(Plain_Ascii.s(),"TAB1")
      If Len(StringField(Plain_Ascii.s(),1,"TAB1")) >  Max_Char_Column.i
        Max_Char_Column.i=Len(StringField(Plain_ascii.s(),1,"TAB1"))
      EndIf
    EndIf
  Next 
  
  ForEach Plain_Ascii.s()
    If FindString(Plain_Ascii.s(),"TAB1")
      Number_of_Spaces_to_Insert.i = Max_Char_Column.i + 4 - Len(StringField(Plain_Ascii.s(),1,"TAB1")) 
      Plain_Ascii.s()=ReplaceString(Plain_Ascii.s(),"TAB1",Space(Number_of_Spaces_to_Insert.i))
    EndIf
  Next
  
  
  ForEach Plain_Ascii.s()
    If FindString(Plain_Ascii.s(),"TAB2")
      If Len(StringField(Plain_Ascii.s(),1,"TAB2")) >  Max_Char_Column.i
        Max_Char_Column.i=Len(StringField(Plain_ascii.s(),1,"TAB2"))
      EndIf
    EndIf
  Next 
  
  ForEach Plain_Ascii.s()
    If FindString(Plain_Ascii.s(),"TAB2")
      Number_of_Spaces_to_Insert.i = Max_Char_Column.i + 4 - Len(StringField(Plain_Ascii.s(),1,"TAB2")) 
      Plain_Ascii.s()=ReplaceString(Plain_Ascii.s(),"TAB2",Space(Number_of_Spaces_to_Insert.i))
    EndIf
  Next
  
  
  ForEach Plain_Ascii.s()
    If FindString(Plain_Ascii.s(),"TAB3")
      If Len(StringField(Plain_Ascii.s(),1,"TAB3")) >  Max_Char_Column.i
        Max_Char_Column.i=Len(StringField(Plain_ascii.s(),1,"TAB3"))
      EndIf
    EndIf
  Next 
  
  ForEach Plain_Ascii.s()
    If FindString(Plain_Ascii.s(),"TAB3")
      Number_of_Spaces_to_Insert.i = Max_Char_Column.i + 4 - Len(StringField(Plain_Ascii.s(),1,"TAB3")) 
      Plain_Ascii.s()=ReplaceString(Plain_Ascii.s(),"TAB3",Space(Number_of_Spaces_to_Insert.i))
    EndIf
  Next
  
  ForEach Plain_Ascii.s()
    If FindString(Plain_Ascii.s(),"TAB4")
      If Len(StringField(Plain_Ascii.s(),1,"TAB4")) >  Max_Char_Column.i
        Max_Char_Column.i=Len(StringField(Plain_ascii.s(),1,"TAB4"))
      EndIf
    EndIf
  Next 
  
  ForEach Plain_Ascii.s()
    If FindString(Plain_Ascii.s(),"TAB4")
      Number_of_Spaces_to_Insert.i = Max_Char_Column.i + 4 - Len(StringField(Plain_Ascii.s(),1,"TAB4")) 
      Plain_Ascii.s()=ReplaceString(Plain_Ascii.s(),"TAB4",Space(Number_of_Spaces_to_Insert.i))
    EndIf
  Next
  
  
  ForEach Plain_Ascii.s()
    If FindString(Plain_Ascii.s(),"TAB5")
      If Len(StringField(Plain_Ascii.s(),1,"TAB5")) >  Max_Char_Column.i
        Max_Char_Column.i=Len(StringField(Plain_ascii.s(),1,"TAB5"))
      EndIf
    EndIf
  Next 
  
  ForEach Plain_Ascii.s()
    If FindString(Plain_Ascii.s(),"TAB5")
      Number_of_Spaces_to_Insert.i = Max_Char_Column.i + 4 - Len(StringField(Plain_Ascii.s(),1,"TAB5")) 
      Plain_Ascii.s()=ReplaceString(Plain_Ascii.s(),"TAB5",Space(Number_of_Spaces_to_Insert.i))
    EndIf
  Next
  
  ForEach Plain_Ascii.s()
    AddGadgetItem(#Editor, Zeile.i, Trim(Plain_Ascii.s()))
    Zeile.i=Zeile.i+1
  Next

EndProcedure

Procedure Create_LaTeX()
  
  ClearList(LaTeX.s())
  ;ClearGadgetItems(#Editor)
  
  Protected SF_1.s, SF_2.s, SF_3.s, SF_4.s, SF_5.s
  Protected MF_1.s, MF_2.s, MF_3.s, MF_4.s, MF_5.s  
  Protected CS_1.s, CS_2.s, CS_3.s, CS_4.s, CS_5.s
  Protected SG_1.s, SG_2.s, SG_3.s, SG_4.s, SG_5.s
  Protected TM_1.s, TM_2.s, TM_3.s, TM_4.s, TM_5.s
  Protected TR_1.s, TR_2.s, TR_3.s, TR_4.s, TR_5.s
  Protected HR_1.s, HR_2.s, HR_3.s, HR_4.s, HR_5.s
  Protected UR_1.s, UR_2.s, UR_3.s, UR_4.s, UR_5.s
  Protected DRP_1.s, DRP_2.s, DRP_3.s, DRP_4.s, DRP_5.s
  Protected R12_1.s, R12_2.s, R12_3.s, R12_4.s, R12_5.s
  Protected R12A_1.s, R12A_2.s, R12A_3.s, R12A_4.s, R12A_5.s
  Protected RE_1.s, RE_2.s, RE_3.s, RE_4.s, RE_5.s
  Protected Caption.s
  Protected NewMap Unit.Units()
  Protected Is_Name_of_Structure_1.b=#False, Is_Name_of_Structure_2.b=#False, Is_Name_of_Structure_3.b=#False, Is_Name_of_Structure_4.b=#False, Is_Name_of_Structure_5.b=#False
  Protected Max_Char_Column.i
  Protected Number_of_Spaces_to_Insert.i
  Protected Zeile.i
  Protected i.i
  
  If GetGadgetState(#SI_Units)=#PB_Checkbox_Checked  
    CopyMap(SI_Units(),Unit())
  Else
    CopyMap(Units(),Unit())
  EndIf
  
  If ListSize(Sum_Formula_1.Summenformel())
    ForEach Sum_Formula_1.Summenformel()
      SF_1.s = SF_1.s + Sum_Formula_1.Summenformel()\Elemente + "$_{" + Sum_Formula_1.Summenformel()\Anzahl + "}$"
    Next
  EndIf
  
  If ListSize(Sum_Formula_2.Summenformel())
    ForEach Sum_Formula_2.Summenformel()
      SF_2.s = SF_2.s + Sum_Formula_2.Summenformel()\Elemente + "$_{" + Sum_Formula_2.Summenformel()\Anzahl + "}$"
    Next
  EndIf
  
  If ListSize(Sum_Formula_3.Summenformel())
    ForEach Sum_Formula_3.Summenformel()
      SF_3.s = SF_3.s + Sum_Formula_3.Summenformel()\Elemente + "$_{" + Sum_Formula_3.Summenformel()\Anzahl + "}$"
    Next
  EndIf
  
  If ListSize(Sum_Formula_4.Summenformel())
    ForEach Sum_Formula_4.Summenformel()
      SF_4.s = SF_4.s + Sum_Formula_4.Summenformel()\Elemente + "$_{" + Sum_Formula_4.Summenformel()\Anzahl + "}$"
    Next
  EndIf
  
  If ListSize(Sum_Formula_5.Summenformel())
    ForEach Sum_Formula_5.Summenformel()
      SF_5.s = SF_5.s + Sum_Formula_5.Summenformel()\Elemente + "$_{" + Sum_Formula_5.Summenformel()\Anzahl + "}$"
    Next
  EndIf
  
  If ListSize(Moiety_Formula_1.Moietyformel())
    ForEach Moiety_Formula_1.Moietyformel()
      MF_1.s = MF_1.s + Moiety_Formula_1.Moietyformel()\Aufklammer + Moiety_Formula_1.Moietyformel()\Elemente + "$_{" + Moiety_Formula_1.Moietyformel()\Anzahl + "}$" + "$^{" + Moiety_Formula_1.Moietyformel()\Ladung + "}$" +  Moiety_Formula_1.Moietyformel()\Zuklammer + Moiety_Formula_1.Moietyformel()\Trennung
      MF_1.s = ReplaceString(MF_1.s," )", ")")
      MF_1.s = RemoveString(MF_1.s,"^{}")
    Next
  EndIf  
  
  If ListSize(Moiety_Formula_2.Moietyformel())
    ForEach Moiety_Formula_2.Moietyformel()
      MF_2.s = MF_2.s + Moiety_Formula_2.Moietyformel()\Aufklammer + Moiety_Formula_2.Moietyformel()\Elemente + "$_{" +  Moiety_Formula_2.Moietyformel()\Anzahl + "}$" + "$^{" + Moiety_Formula_2.Moietyformel()\Ladung + "}$" + Moiety_Formula_2.Moietyformel()\Zuklammer + Moiety_Formula_2.Moietyformel()\Trennung
      MF_2.s = ReplaceString(MF_2.s," )", ")")
      MF_2.s = RemoveString(MF_2.s,"^{}")
    Next
  EndIf  
  
  If ListSize(Moiety_Formula_3.Moietyformel())
    ForEach Moiety_Formula_3.Moietyformel()
      MF_3.s = MF_3.s + Moiety_Formula_3.Moietyformel()\Aufklammer + Moiety_Formula_3.Moietyformel()\Elemente + "$_{" + Moiety_Formula_3.Moietyformel()\Anzahl + "}$" + "$^{" + Moiety_Formula_3.Moietyformel()\Ladung + "}$" + Moiety_Formula_3.Moietyformel()\Zuklammer + Moiety_Formula_3.Moietyformel()\Trennung
      MF_3.s = ReplaceString(MF_3.s," )", ")")
      MF_3.s = RemoveString(MF_3.s,"^{}")
    Next
  EndIf  
  
  If ListSize(Moiety_Formula_4.Moietyformel())
    ForEach Moiety_Formula_4.Moietyformel()
      MF_4.s = MF_4.s+ Moiety_Formula_4.Moietyformel()\Aufklammer + Moiety_Formula_4.Moietyformel()\Elemente + "$_{" + Moiety_Formula_4.Moietyformel()\Anzahl + "}$" + "$^{" + Moiety_Formula_4.Moietyformel()\Ladung + "}$" + Moiety_Formula_4.Moietyformel()\Zuklammer + Moiety_Formula_4.Moietyformel()\Trennung
      MF_4.s = ReplaceString(MF_4.s," )", ")")
      MF_4.s = RemoveString(MF_4.s,"^{}")
    Next
  EndIf   
  
  If ListSize(Moiety_Formula_5.Moietyformel())
    ForEach Moiety_Formula_5.Moietyformel()
      MF_5.s = MF_5.s + Moiety_Formula_5.Moietyformel()\Aufklammer + Moiety_Formula_5.Moietyformel()\Elemente + "$_{" + Moiety_Formula_5.Moietyformel()\Anzahl + "}$" + "$^{" + Moiety_Formula_5.Moietyformel()\Ladung + "}$" + Moiety_Formula_5.Moietyformel()\Zuklammer + Moiety_Formula_5.Moietyformel()\Trennung
      MF_5.s = ReplaceString(MF_5.s," )", ")")
      MF_5.s = RemoveString(MF_5.s,"^{}")
    Next
  EndIf   
  
  CS_1.s = CIF_Items_1.s("_exptl_crystal_size_max") + " $\times$ " + CIF_Items_1.s("_exptl_crystal_size_mid") + " $\times$ " + CIF_Items_1.s("_exptl_crystal_size_min") 
  CS_2.s = CIF_Items_2.s("_exptl_crystal_size_max") + " $\times$ " + CIF_Items_2.s("_exptl_crystal_size_mid") + " $\times$ " + CIF_Items_2.s("_exptl_crystal_size_min") 
  CS_3.s = CIF_Items_3.s("_exptl_crystal_size_max") + " $\times$ " + CIF_Items_3.s("_exptl_crystal_size_mid") + " $\times$ " + CIF_Items_3.s("_exptl_crystal_size_min")
  CS_4.s = CIF_Items_4.s("_exptl_crystal_size_max") + " $\times$ " + CIF_Items_4.s("_exptl_crystal_size_mid") + " $\times$ " + CIF_Items_4.s("_exptl_crystal_size_min")
  CS_5.s = CIF_Items_5.s("_exptl_crystal_size_max") + " $\times$ " + CIF_Items_5.s("_exptl_crystal_size_mid") + " $\times$ " + CIF_Items_5.s("_exptl_crystal_size_min")
  
  If CS_1.s=" $\times$  $\times$ " : CS_1.s="" : EndIf
  If CS_2.s=" $\times$  $\times$ " : CS_2.s="" : EndIf
  If CS_3.s=" $\times$  $\times$ " : CS_3.s="" : EndIf
  If CS_4.s=" $\times$  $\times$ " : CS_4.s="" : EndIf
  If CS_5.s=" $\times$  $\times$ " : CS_5.s="" : EndIf
  
  SG_1.s = "$" + SPG_Dict_Latex(RemoveString(Trim(CIF_Items_1.s("_space_group_name_H-M_alt"),"'")," ")) + "$" + " (No. " + CIF_Items_1.s("_space_group_IT_number") + ")" + "$" + SPG_Dict_Latex(RemoveString(Trim(CIF_Items_1.s("_symmetry_space_group_name_H-M"),"'")," ")) + "$"
  SG_2.s = "$" + SPG_Dict_Latex(RemoveString(Trim(CIF_Items_2.s("_space_group_name_H-M_alt"),"'")," ")) + "$" + " (No. " + CIF_Items_2.s("_space_group_IT_number") + ")" + "$" + SPG_Dict_Latex(RemoveString(Trim(CIF_Items_2.s("_symmetry_space_group_name_H-M"),"'")," ")) + "$"
  SG_3.s = "$" + SPG_Dict_Latex(RemoveString(Trim(CIF_Items_3.s("_space_group_name_H-M_alt"),"'")," ")) + "$" + " (No. " + CIF_Items_3.s("_space_group_IT_number") + ")" + "$" + SPG_Dict_Latex(RemoveString(Trim(CIF_Items_3.s("_symmetry_space_group_name_H-M"),"'")," ")) + "$"
  SG_4.s = "$" + SPG_Dict_Latex(RemoveString(Trim(CIF_Items_4.s("_space_group_name_H-M_alt"),"'")," ")) + "$" + " (No. " + CIF_Items_4.s("_space_group_IT_number") + ")" + "$" + SPG_Dict_Latex(RemoveString(Trim(CIF_Items_4.s("_symmetry_space_group_name_H-M"),"'")," ")) + "$"
  SG_5.s = "$" + SPG_Dict_Latex(RemoveString(Trim(CIF_Items_5.s("_space_group_name_H-M_alt"),"'")," ")) + "$" + " (No. " + CIF_Items_5.s("_space_group_IT_number") + ")" + "$" + SPG_Dict_Latex(RemoveString(Trim(CIF_Items_5.s("_symmetry_space_group_name_H-M"),"'")," ")) + "$"
  
  SG_1.s = RemoveString(SG_1.s," (No. " + ")")
  SG_2.s = RemoveString(SG_2.s," (No. " + ")")
  SG_3.s = RemoveString(SG_3.s," (No. " + ")")
  SG_4.s = RemoveString(SG_4.s," (No. " + ")")
  SG_5.s = RemoveString(SG_5.s," (No. " + ")")
  
  TM_1.s = CIF_Items_1.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_1.s("_exptl_absorpt_correction_T_max")
  TM_2.s = CIF_Items_2.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_2.s("_exptl_absorpt_correction_T_max")
  TM_3.s = CIF_Items_3.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_3.s("_exptl_absorpt_correction_T_max")
  TM_4.s = CIF_Items_4.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_4.s("_exptl_absorpt_correction_T_max")
  TM_5.s = CIF_Items_5.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_5.s("_exptl_absorpt_correction_T_max")
  
  If TM_1.s=" / " : TM_1.s="" : EndIf
  If TM_2.s=" / " : TM_2.s="" : EndIf
  If TM_3.s=" / " : TM_3.s="" : EndIf
  If TM_4.s=" / " : TM_4.s="" : EndIf
  If TM_5.s=" / " : TM_5.s="" : EndIf
  
  TR_1.s = CIF_Items_1.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_1.s("_diffrn_reflns_theta_max")
  TR_2.s = CIF_Items_2.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_2.s("_diffrn_reflns_theta_max")
  TR_3.s = CIF_Items_3.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_3.s("_diffrn_reflns_theta_max")
  TR_4.s = CIF_Items_4.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_4.s("_diffrn_reflns_theta_max")
  TR_5.s = CIF_Items_5.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_5.s("_diffrn_reflns_theta_max")
  
  If TR_1.s=" - " : TR_1.s="" : EndIf
  If TR_2.s=" - " : TR_2.s="" : EndIf
  If TR_3.s=" - " : TR_3.s="" : EndIf
  If TR_4.s=" - " : TR_4.s="" : EndIf
  If TR_5.s=" - " : TR_5.s="" : EndIf
  
  UR_1.s = CIF_Items_1.s("_reflns_number_total") + " [" + CIF_Items_1.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_2.s = CIF_Items_2.s("_reflns_number_total") + " [" + CIF_Items_2.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_3.s = CIF_Items_3.s("_reflns_number_total") + " [" + CIF_Items_3.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_4.s = CIF_Items_4.s("_reflns_number_total") + " [" + CIF_Items_4.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_5.s = CIF_Items_5.s("_reflns_number_total") + " [" + CIF_Items_5.s("_diffrn_reflns_av_R_equivalents") + "]"
  
  If UR_1.s=" []" : UR_1.s="" : EndIf
  If UR_2.s=" []" : UR_2.s="" : EndIf
  If UR_3.s=" []" : UR_3.s="" : EndIf
  If UR_4.s=" []" : UR_4.s="" : EndIf
  If UR_5.s=" []" : UR_5.s="" : EndIf
  
  DRP_1.s = CIF_Items_1.s("_reflns_number_total") + " / " + CIF_Items_1.s("_refine_ls_number_restraints")  + " / " + CIF_Items_1.s("_refine_ls_number_parameters")
  DRP_2.s = CIF_Items_2.s("_reflns_number_total") + " / " + CIF_Items_2.s("_refine_ls_number_restraints")  + " / " + CIF_Items_2.s("_refine_ls_number_parameters")
  DRP_3.s = CIF_Items_3.s("_reflns_number_total") + " / " + CIF_Items_3.s("_refine_ls_number_restraints")  + " / " + CIF_Items_3.s("_refine_ls_number_parameters")
  DRP_4.s = CIF_Items_4.s("_reflns_number_total") + " / " + CIF_Items_4.s("_refine_ls_number_restraints")  + " / " + CIF_Items_4.s("_refine_ls_number_parameters")
  DRP_5.s = CIF_Items_5.s("_reflns_number_total") + " / " + CIF_Items_5.s("_refine_ls_number_restraints")  + " / " + CIF_Items_5.s("_refine_ls_number_parameters")
  
  If DRP_1.s=" /  / " : DRP_1.s="" : EndIf
  If DRP_2.s=" /  / " : DRP_2.s="" : EndIf
  If DRP_3.s=" /  / " : DRP_3.s="" : EndIf
  If DRP_4.s=" /  / " : DRP_4.s="" : EndIf
  If DRP_5.s=" /  / " : DRP_5.s="" : EndIf
  
  R12_1.s = CIF_Items_1.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_1.s("_refine_ls_wR_factor_gt")
  R12_2.s = CIF_Items_2.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_2.s("_refine_ls_wR_factor_gt")
  R12_3.s = CIF_Items_3.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_3.s("_refine_ls_wR_factor_gt")
  R12_4.s = CIF_Items_4.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_4.s("_refine_ls_wR_factor_gt")
  R12_5.s = CIF_Items_5.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_5.s("_refine_ls_wR_factor_gt")
  
  If R12_1.s=" / " : R12_1.s="" : EndIf
  If R12_2.s=" / " : R12_2.s="" : EndIf
  If R12_3.s=" / " : R12_3.s="" : EndIf
  If R12_4.s=" / " : R12_4.s="" : EndIf
  If R12_5.s=" / " : R12_5.s="" : EndIf
  
  R12A_1.s = CIF_Items_1.s("_refine_ls_R_factor_all") + " / " + CIF_Items_1.s("_refine_ls_wR_factor_ref")
  R12A_2.s = CIF_Items_2.s("_refine_ls_R_factor_all") + " / " + CIF_Items_2.s("_refine_ls_wR_factor_ref")
  R12A_3.s = CIF_Items_3.s("_refine_ls_R_factor_all") + " / " + CIF_Items_3.s("_refine_ls_wR_factor_ref")
  R12A_4.s = CIF_Items_4.s("_refine_ls_R_factor_all") + " / " + CIF_Items_4.s("_refine_ls_wR_factor_ref")
  R12A_5.s = CIF_Items_5.s("_refine_ls_R_factor_all") + " / " + CIF_Items_5.s("_refine_ls_wR_factor_ref")
  
  If R12A_1.s=" / " : R12A_1.s="" : EndIf
  If R12A_2.s=" / " : R12A_2.s="" : EndIf
  If R12A_3.s=" / " : R12A_3.s="" : EndIf
  If R12A_4.s=" / " : R12A_4.s="" : EndIf
  If R12A_5.s=" / " : R12A_5.s="" : EndIf
  
  RE_1.s = "$" + CIF_Items_1.s("_refine_diff_density_min") + "$" +  " / " + "$" + CIF_Items_1.s("_refine_diff_density_max") + "$"
  RE_2.s = "$" + CIF_Items_2.s("_refine_diff_density_min") + "$" +  " / " + "$" + CIF_Items_2.s("_refine_diff_density_max") + "$"
  RE_3.s = "$" + CIF_Items_3.s("_refine_diff_density_min") + "$" +  " / " + "$" + CIF_Items_3.s("_refine_diff_density_max") + "$"
  RE_4.s = "$" + CIF_Items_4.s("_refine_diff_density_min") + "$" +  " / " + "$" + CIF_Items_4.s("_refine_diff_density_max") + "$"
  RE_5.s = "$" + CIF_Items_5.s("_refine_diff_density_min") + "$" +  " / " + "$" + CIF_Items_5.s("_refine_diff_density_max") + "$"
  
  If RE_1.s="$$ / $$" : RE_1.s="" : EndIf
  If RE_2.s="$$ / $$" : RE_2.s="" : EndIf
  If RE_3.s="$$ / $$" : RE_3.s="" : EndIf
  If RE_4.s="$$ / $$" : RE_4.s="" : EndIf
  If RE_5.s="$$ / $$" : RE_5.s="" : EndIf
 
  If Name_of_Structure_1.s : Is_Name_of_Structure_1.b=#True : EndIf
  If Name_of_Structure_2.s : Is_Name_of_Structure_2.b=#True : EndIf
  If Name_of_Structure_3.s : Is_Name_of_Structure_3.b=#True : EndIf
  If Name_of_Structure_4.s : Is_Name_of_Structure_4.b=#True : EndIf
  If Name_of_Structure_5.s : Is_Name_of_Structure_5.b=#True : EndIf
  
  If Is_Name_of_Structure_1.b And Not Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    If SG_1.s = "$$$$" : SG_1.s="?" : EndIf
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    If SG_1.s = "$$$$" : SG_1.s="?" : EndIf
    If SG_2.s = "$$$$" : SG_2.s="?" : EndIf
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    If SG_1.s = "$$$$" : SG_1.s="?" : EndIf
    If SG_2.s = "$$$$" : SG_2.s="?" : EndIf
    If SG_3.s = "$$$$" : SG_3.s="?" : EndIf
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    If SG_1.s = "$$$$" : SG_1.s="?" : EndIf
    If SG_2.s = "$$$$" : SG_2.s="?" : EndIf
    If SG_3.s = "$$$$" : SG_3.s="?" : EndIf
    If SG_4.s = "$$$$" : SG_4.s="?" : EndIf
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Is_Name_of_Structure_5.b
    If SG_1.s = "$$$$" : SG_1.s="?" : EndIf
    If SG_2.s = "$$$$" : SG_2.s="?" : EndIf
    If SG_3.s = "$$$$" : SG_3.s="?" : EndIf
    If SG_4.s = "$$$$" : SG_4.s="?" : EndIf
    If SG_5.s = "$$$$" : SG_5.s="?" : EndIf
  EndIf
  
  If Is_Name_of_Structure_1.b And Not Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "Crystal data and refinement details for " + "\textbf{" + Name_of_Structure_1.s + "}" + "." 
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "Crystal data and refinement details for " + "\textbf{" + Name_of_Structure_1.s + "}" + " and " + "\textbf{" + Name_of_Structure_2.s + "}" +  "."
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "Crystal data and refinement details for " + "\textbf{" + Name_of_Structure_1.s + "}" + ", " + "\textbf{" + Name_of_Structure_2.s + "}" +  ", and " + "\textbf{" + Name_of_Structure_3.s + "}" + "."
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "Crystal data and refinement details for " + "\textbf{" + Name_of_Structure_1.s + "}" + ", " + "\textbf{" + Name_of_Structure_2.s + "}" +  ", " + "\textbf{" + Name_of_Structure_3.s + "}" + ", and " + "\textbf{" + Name_of_Structure_4.s + "}" + "."
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Is_Name_of_Structure_5.b
    Caption.s= "Crystal data and refinement details for " + "\textbf{" + Name_of_Structure_1.s + "}" + ", " + "\textbf{" + Name_of_Structure_2.s + "}" +  ", " + "\textbf{" + Name_of_Structure_3.s + "}" + ", " + "\textbf{" + Name_of_Structure_4.s + "}" + ", and " + "\textbf{" + Name_of_Structure_5.s + "}" + "."
  EndIf
  
  If GetGadgetState(#A4_Auto)
    If Is_Name_of_Structure_1.b And Not Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
      AddElement(LaTeX.s()) : LaTeX.s() = "\documentclass[a4paper]{scrartcl}"
    ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
      AddElement(LaTeX.s()) : LaTeX.s() = "\documentclass[a4paper]{scrartcl}"
    ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
      AddElement(LaTeX.s()) : LaTeX.s() = "\documentclass[a4paper]{scrartcl}"
    ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
      AddElement(LaTeX.s()) : LaTeX.s() = "\documentclass[a4paper,landscape]{scrartcl}"
    ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Is_Name_of_Structure_5.b
      AddElement(LaTeX.s()) : LaTeX.s() = "\documentclass[a4paper,landscape]{scrartcl}"
    EndIf
  ElseIf GetGadgetState(#A4_Portrait)
    AddElement(LaTeX.s()) : LaTeX.s() = "\documentclass[a4paper]{scrartcl}"
  ElseIf GetGadgetState(#A4_Landscape)
    AddElement(LaTeX.s()) : LaTeX.s() = "\documentclass[a4paper,landscape]{scrartcl}"
  EndIf
  
  AddElement(LaTeX.s()) : LaTeX.s() = "\usepackage[nooneline]{caption}"
  AddElement(LaTeX.s()) : LaTeX.s() = "\usepackage{geometry}"
  AddElement(LaTeX.s()) : LaTeX.s() = "\geometry{a4paper,left=30mm,right=30mm, top=2cm, bottom=2cm}"
  AddElement(LaTeX.s()) : LaTeX.s() = "\begin{document}"
  AddElement(LaTeX.s()) : LaTeX.s() = "\begin{table}[ht]"

  AddElement(LaTeX.s()) : LaTeX.s() = "\caption{" + Caption.s +"}"
  
  If Is_Name_of_Structure_1.b And Not Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    AddElement(LaTeX.s()) : LaTeX.s() = "\begin{tabular}{ll}"
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    AddElement(LaTeX.s()) : LaTeX.s() = "\begin{tabular}{lll}"
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    AddElement(LaTeX.s()) : LaTeX.s() = "\begin{tabular}{llll}"
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    AddElement(LaTeX.s()) : LaTeX.s() = "\begin{tabular}{lllll}"
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Is_Name_of_Structure_5.b
    AddElement(LaTeX.s()) : LaTeX.s() = "\begin{tabular}{llllll}"
  EndIf
  
  AddElement(LaTeX.s()) : LaTeX.s() = "\hline"
    
  AddElement(LaTeX.s()) : LaTeX.s() = "\textbf{compound}" + "TAB1" + "\textbf{" + Name_of_Structure_1.s + "}" + "TAB2" + "\textbf{" + Name_of_Structure_2.s + "}" + "TAB3" + "\textbf{" + Name_of_Structure_3.s + "}" + "TAB4" + "\textbf{" + Name_of_Structure_4.s + "}" + "TAB5" + "\textbf{" + Name_of_Structure_5.s + "}" + " \\"
  
  AddElement(LaTeX.s()) : LaTeX.s() = "\hline"
  
  AddElement(LaTeX.s()) : LaTeX.s() = "empirical formula" + "TAB1" + SF_1.s + "TAB2" + SF_2.s + "TAB3" + SF_3.s + "TAB4" + SF_4.s + "TAB5" + SF_5.s + " \\"
  If GetGadgetState(#Include_Moiety)=#PB_Checkbox_Checked 
    AddElement(LaTeX.s()) : LaTeX.s() = "moiety formula" + "TAB1" + MF_1.s + "TAB2" + MF_2.s + "TAB3" + MF_3.s + "TAB4" + MF_4.s + "TAB5" + MF_5.s + " \\"
  EndIf
  AddElement(LaTeX.s()) : LaTeX.s() = "formula weight" + "TAB1" + CIF_Items_1.s("_chemical_formula_weight") +
                                                  "TAB2" + CIF_Items_2.s("_chemical_formula_weight") +
                                                  "TAB3" + CIF_Items_3.s("_chemical_formula_weight") +
                                                  "TAB4" + CIF_Items_4.s("_chemical_formula_weight") +
                                                  "TAB5" + CIF_Items_5.s("_chemical_formula_weight") + " \\"
  If GetGadgetState(#Include_T)=#PB_Checkbox_Checked 
    AddElement(LaTeX.s()) : LaTeX.s() = "$T$\," + Unit("Kel")\Unit_LTX + "TAB1" + CIF_Items_1.s("_diffrn_ambient_temperature") + 
                                                    "TAB2" + CIF_Items_2.s("_diffrn_ambient_temperature") +
                                                    "TAB3" + CIF_Items_3.s("_diffrn_ambient_temperature") +
                                                    "TAB4" + CIF_Items_4.s("_diffrn_ambient_temperature") +
                                                    "TAB5" + CIF_Items_5.s("_diffrn_ambient_temperature") + " \\"
  EndIf
  AddElement(LaTeX.s()) : LaTeX.s() = "crystal size\," + Unit("Siz")\Unit_LTX + "TAB1" + CS_1.s + "TAB2" + CS_2.s + "TAB3" + CS_3.s + "TAB4" + CS_4.s + "TAB5" + CS_5.s   + " \\"                                         
  AddElement(LaTeX.s()) : LaTeX.s() = "crystal system" + "TAB1" + CIF_Items_1.s("_space_group_crystal_system") + CIF_Items_1.s("_symmetry_cell_setting") + 
                                                  "TAB2" + CIF_Items_2.s("_space_group_crystal_system") + CIF_Items_2.s("_symmetry_cell_setting") +
                                                  "TAB3" + CIF_Items_3.s("_space_group_crystal_system") + CIF_Items_3.s("_symmetry_cell_setting") +
                                                  "TAB4" + CIF_Items_4.s("_space_group_crystal_system") + CIF_Items_4.s("_symmetry_cell_setting") +
                                                  "TAB5" + CIF_Items_5.s("_space_group_crystal_system") + CIF_Items_5.s("_symmetry_cell_setting") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "space group" + "TAB1" + SG_1.s + "TAB2" + SG_2.s + "TAB3" + SG_3.s + "TAB4" + SG_4.s + "TAB5" + SG_5.s + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$a$\," + Unit("Ang")\Unit_LTX + "TAB1" + CIF_Items_1.s("_cell_length_a") +
                                                  "TAB2" + CIF_Items_2.s("_cell_length_a") +
                                                  "TAB3" + CIF_Items_3.s("_cell_length_a") +
                                                  "TAB4" + CIF_Items_4.s("_cell_length_a") +
                                                  "TAB5" + CIF_Items_5.s("_cell_length_a") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$b$\," + Unit("Ang")\Unit_LTX + "TAB1" + CIF_Items_1.s("_cell_length_b") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_length_b") +
                                                  "TAB3" + CIF_Items_3.s("_cell_length_b") +
                                                  "TAB4" + CIF_Items_4.s("_cell_length_b") +
                                                  "TAB5" + CIF_Items_5.s("_cell_length_b") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$c$\," + Unit("Ang")\Unit_LTX + "TAB1" + CIF_Items_1.s("_cell_length_c") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_length_c") +
                                                  "TAB3" + CIF_Items_3.s("_cell_length_c") +
                                                  "TAB4" + CIF_Items_4.s("_cell_length_c") +
                                                  "TAB5" + CIF_Items_5.s("_cell_length_c") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$\alpha$\," + Unit("Deg")\Unit_LTX + "TAB1" + CIF_Items_1.s("_cell_angle_alpha") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_angle_alpha") +
                                                  "TAB3" + CIF_Items_3.s("_cell_angle_alpha") +
                                                  "TAB4" + CIF_Items_4.s("_cell_angle_alpha") +
                                                  "TAB5" + CIF_Items_5.s("_cell_angle_alpha") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$\beta$\," + Unit("Deg")\Unit_LTX + "TAB1" + CIF_Items_1.s("_cell_angle_beta") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_angle_beta") +
                                                  "TAB3" + CIF_Items_3.s("_cell_angle_beta") +
                                                  "TAB4" + CIF_Items_4.s("_cell_angle_beta") +
                                                  "TAB5" + CIF_Items_5.s("_cell_angle_beta") + " \\"  
  AddElement(LaTeX.s()) : LaTeX.s() = "$\gamma$\," + Unit("Deg")\Unit_LTX + "TAB1" + CIF_Items_1.s("_cell_angle_gamma") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_angle_gamma") +
                                                  "TAB3" + CIF_Items_3.s("_cell_angle_gamma") +
                                                  "TAB4" + CIF_Items_4.s("_cell_angle_gamma") +
                                                  "TAB5" + CIF_Items_5.s("_cell_angle_gamma") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$V$\," + Unit("Vol")\Unit_LTX + "TAB1" + CIF_Items_1.s("_cell_volume") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_volume") +
                                                  "TAB3" + CIF_Items_3.s("_cell_volume") +
                                                  "TAB4" + CIF_Items_4.s("_cell_volume") +
                                                  "TAB5" + CIF_Items_5.s("_cell_volume") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$Z$" + "TAB1" + CIF_Items_1.s("_cell_formula_units_Z") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_formula_units_Z") +
                                                  "TAB3" + CIF_Items_3.s("_cell_formula_units_Z") +
                                                  "TAB4" + CIF_Items_4.s("_cell_formula_units_Z") +
                                                  "TAB5" + CIF_Items_5.s("_cell_formula_units_Z") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$\rho$\," + Unit("Rho")\Unit_LTX + "TAB1" + CIF_Items_1.s("_exptl_crystal_density_diffrn") + 
                                                  "TAB2" + CIF_Items_2.s("_exptl_crystal_density_diffrn") +
                                                  "TAB3" + CIF_Items_3.s("_exptl_crystal_density_diffrn") +
                                                  "TAB4" + CIF_Items_4.s("_exptl_crystal_density_diffrn") +
                                                  "TAB5" + CIF_Items_5.s("_exptl_crystal_density_diffrn") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$F(000)$" + "TAB1" + CIF_Items_1.s("_exptl_crystal_F_000") + 
                                                  "TAB2" + CIF_Items_2.s("_exptl_crystal_F_000") +
                                                  "TAB3" + CIF_Items_3.s("_exptl_crystal_F_000") +
                                                  "TAB4" + CIF_Items_4.s("_exptl_crystal_F_000") +
                                                  "TAB5" + CIF_Items_5.s("_exptl_crystal_F_000") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$\mu$\," + Unit("Abs")\Unit_LTX + "TAB1" + CIF_Items_1.s("_exptl_absorpt_coefficient_mu") + 
                                                  "TAB2" + CIF_Items_2.s("_exptl_absorpt_coefficient_mu") +
                                                  "TAB3" + CIF_Items_3.s("_exptl_absorpt_coefficient_mu") +
                                                  "TAB4" + CIF_Items_4.s("_exptl_absorpt_coefficient_mu") +
                                                  "TAB5" + CIF_Items_5.s("_exptl_absorpt_coefficient_mu") + " \\"

  AddElement(LaTeX.s()) : LaTeX.s() = "$T_\mathrm {min}$ / $T_\mathrm {max}$" + "TAB1" + TM_1.s + "TAB2" + TM_2.s + "TAB3" + TM_3.s + "TAB4" + TM_4.s + "TAB5" + TM_5.s + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$\theta$-range\,"  + Unit("Deg")\Unit_LTX + "TAB1" + TR_1.s + "TAB2" + TR_2.s + "TAB3" + TR_3.s + "TAB4" + TR_4.s + "TAB5" + TR_5.s + " \\"
  
  AddElement(LaTeX.s()) : LaTeX.s() = "$hkl$-range" + "TAB1" + "$" + CIF_Items_1.s("_diffrn_reflns_limit_h_min")  + "\leq h \leq" + CIF_Items_1.s("_diffrn_reflns_limit_h_max") + "$" + 
                                      "TAB2" + "$" + CIF_Items_2.s("_diffrn_reflns_limit_h_min")  + "\leq h \leq" + CIF_Items_2.s("_diffrn_reflns_limit_h_max") + "$" +
                                      "TAB3" + "$" + CIF_Items_3.s("_diffrn_reflns_limit_h_min")  + "\leq h \leq" + CIF_Items_3.s("_diffrn_reflns_limit_h_max") + "$" +
                                      "TAB4" + "$" + CIF_Items_4.s("_diffrn_reflns_limit_h_min")  + "\leq h \leq" + CIF_Items_4.s("_diffrn_reflns_limit_h_max") + "$" +
                                      "TAB5" + "$" + CIF_Items_5.s("_diffrn_reflns_limit_h_min")  + "\leq h \leq" + CIF_Items_5.s("_diffrn_reflns_limit_h_max") + "$" + " \\"
  LaTeX.s() = RemoveString(LaTeX.s(),"$" + "\leq h \leq" + "$")
  
  AddElement(LaTeX.s()) : LaTeX.s() = "TAB1" + "$" + CIF_Items_1.s("_diffrn_reflns_limit_k_min")  + "\leq k \leq" + CIF_Items_1.s("_diffrn_reflns_limit_k_max") + "$" + 
                                      "TAB2" + "$" + CIF_Items_2.s("_diffrn_reflns_limit_k_min")  + "\leq k \leq" + CIF_Items_2.s("_diffrn_reflns_limit_k_max") + "$" +
                                      "TAB3" + "$" + CIF_Items_3.s("_diffrn_reflns_limit_k_min")  + "\leq k \leq" + CIF_Items_3.s("_diffrn_reflns_limit_k_max") + "$" +
                                      "TAB4" + "$" + CIF_Items_4.s("_diffrn_reflns_limit_k_min")  + "\leq k \leq" + CIF_Items_4.s("_diffrn_reflns_limit_k_max") + "$" +
                                      "TAB5" + "$" + CIF_Items_5.s("_diffrn_reflns_limit_k_min")  + "\leq k \leq" + CIF_Items_5.s("_diffrn_reflns_limit_k_max") + "$" + " \\"
  LaTeX.s() = RemoveString(LaTeX.s(),"$" + "\leq k \leq" + "$")
  
  AddElement(LaTeX.s()) : LaTeX.s() = "TAB1" + "$" + CIF_Items_1.s("_diffrn_reflns_limit_l_min")  + "\leq l \leq" + CIF_Items_1.s("_diffrn_reflns_limit_k_max") + "$" + 
                                      "TAB2" + "$" + CIF_Items_2.s("_diffrn_reflns_limit_l_min")  + "\leq l \leq" + CIF_Items_2.s("_diffrn_reflns_limit_l_max") + "$" +
                                      "TAB3" + "$" + CIF_Items_3.s("_diffrn_reflns_limit_l_min")  + "\leq l \leq" + CIF_Items_3.s("_diffrn_reflns_limit_l_max") + "$" +
                                      "TAB4" + "$" + CIF_Items_4.s("_diffrn_reflns_limit_l_min")  + "\leq l \leq" + CIF_Items_4.s("_diffrn_reflns_limit_l_max") + "$" +
                                      "TAB5" + "$" + CIF_Items_5.s("_diffrn_reflns_limit_l_min")  + "\leq l \leq" + CIF_Items_5.s("_diffrn_reflns_limit_l_max") + "$" + " \\"
  LaTeX.s() = RemoveString(LaTeX.s(),"$" + "\leq l \leq" + "$")
  
  AddElement(LaTeX.s()) : LaTeX.s() = "measured refl." + "TAB1" + CIF_Items_1.s("_diffrn_reflns_number") + 
                                                  "TAB2" + CIF_Items_2.s("_diffrn_reflns_number") +
                                                  "TAB3" + CIF_Items_3.s("_diffrn_reflns_number") +
                                                  "TAB4" + CIF_Items_4.s("_diffrn_reflns_number") +
                                                  "TAB5" + CIF_Items_5.s("_diffrn_reflns_number") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "unique refl.\,[$R_\mathrm {int}$]" + "TAB1" + UR_1.s + "TAB2" + UR_2.s + "TAB3" + UR_3.s + "TAB4" + UR_4.s + "TAB5" + UR_5.s + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "obs. refl.\,($I > 2\sigma (I)$)" + "TAB1" + CIF_Items_1.s("_reflns_number_gt") + 
                                                  "TAB2" + CIF_Items_2.s("_reflns_number_gt") +
                                                  "TAB3" + CIF_Items_3.s("_reflns_number_gt") +
                                                  "TAB4" + CIF_Items_4.s("_reflns_number_gt") +
                                                  "TAB5" + CIF_Items_5.s("_reflns_number_gt") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "data / restr. / param." + "TAB1" + DRP_1.s + "TAB2" + DRP_2.s + "TAB3" + DRP_3.s + "TAB4" + DRP_4.s + "TAB5" + DRP_5.s + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "goodness-of-fit\,($F^2$)"  + "TAB1" + CIF_Items_1.s("_refine_ls_goodness_of_fit_ref") + 
                                                  "TAB2" + CIF_Items_2.s("_refine_ls_goodness_of_fit_ref") +
                                                  "TAB3" + CIF_Items_3.s("_refine_ls_goodness_of_fit_ref") +
                                                  "TAB4" + CIF_Items_4.s("_refine_ls_goodness_of_fit_ref") +
                                                  "TAB5" + CIF_Items_5.s("_refine_ls_goodness_of_fit_ref") + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$R1$, $wR2$\,($I > 2\sigma (I)$)" + "TAB1" + R12_1.s + "TAB2" + R12_2.s + "TAB3" + R12_3.s + "TAB4" + R12_4.s + "TAB5" + R12_5.s + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "$R1$, $wR2$\,(all data)" + "TAB1" + R12A_1.s + "TAB2" + R12A_2.s + "TAB3" + R12A_3.s + "TAB4" + R12A_4.s + "TAB5" + R12A_5.s + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "res. el. dens. "  + Unit("Red")\Unit_LTX + "TAB1" + RE_1.s + "TAB2" + RE_2.s + "TAB3" + RE_3.s + "TAB4" + RE_4.s + "TAB5" + RE_5.s + " \\"
  AddElement(LaTeX.s()) : LaTeX.s() = "\hline"
  AddElement(LaTeX.s()) : LaTeX.s() = "\end{tabular}"
  AddElement(LaTeX.s()) : LaTeX.s() = "\end{table}"  
  AddElement(LaTeX.s()) : LaTeX.s() = "\end{document}"
  
  
  ForEach LaTeX.s()
    LaTeX.s()=ReplaceString(LaTeX.s(),"TAB1"," & ")
    LaTeX.s()=ReplaceString(LaTeX.s(),"TAB2"," & ")
    LaTeX.s()=ReplaceString(LaTeX.s(),"TAB3"," & ")
    LaTeX.s()=ReplaceString(LaTeX.s(),"TAB4"," & ")
    LaTeX.s()=ReplaceString(LaTeX.s(),"TAB5"," & ")
    LaTeX.s()=RemoveString(LaTeX.s(),"\textbf{}")
    LaTeX.s()=RemoveString(LaTeX.s(),"$$")
    LaTeX.s()=RemoveString(LaTeX.s(),"$_{}$")
    LaTeX.s()=RemoveString(LaTeX.s(),"&  &  &  &  ")
    LaTeX.s()=RemoveString(LaTeX.s(),"&  &  &  ")
    LaTeX.s()=RemoveString(LaTeX.s(),"&  &  ")
    LaTeX.s()=RemoveString(LaTeX.s(),"&  ")
    
  Next
  
;   ForEach LaTeX.s()
;     AddGadgetItem(#Editor, Zeile.i, Trim(LaTeX.s()))
;     Zeile.i=Zeile.i+1
;   Next
  
EndProcedure

Procedure Create_RTF()
  Protected Leerzeile_RTF.s="{\pard\plain \f0\fs24 \par}"
 ; New autofit, does not work with WordPad
;   Protected TR1.s="{\trowd\trautofit1\clftsWidth1\cellx1\clftsWidth1\cellx2\pard\intbl \f0\fs24 " 
;   Protected TR12.s="{\trowd\trautofit1\clftsWidth1\cellx1\clftsWidth1\cellx2\clftsWidth1\cellx3\pard\intbl \f0\fs24 "
;   Protected TR13.s="{\trowd\trautofit1\clftsWidth1\cellx1\clftsWidth1\cellx2\clftsWidth1\cellx3\clftsWidth1\cellx4\pard\intbl \f0\fs24 "
;   Protected TR14.s="{\trowd\trautofit1\clftsWidth1\cellx1\clftsWidth1\cellx2\clftsWidth1\cellx3\clftsWidth1\cellx4\clftsWidth1\cellx5\pard\intbl \f0\fs24 "
;   Protected TR15.s="{\trowd\trautofit1\clftsWidth1\cellx1\clftsWidth1\cellx2\clftsWidth1\cellx3\clftsWidth1\cellx4\clftsWidth1\cellx5\clftsWidth1\cellx6\pard\intbl \f0\fs24 "
  Protected TR2.s="\cell\pard\intbl \f0\fs24 "  
  Protected TR3.s="\cell\row}"
  Protected TR1.s="{\trowd\trgaph108\trql\cellx3600\cellx7200\pard\intbl \f0\fs24 "
  Protected TR12.s="{\trowd\trgaph108\trql\cellx3000\cellx6000\cellx9000\pard\intbl \f0\fs24 "
  Protected TR13.s="{\trowd\trgaph108\trql\cellx2000\cellx4300\cellx6600\cellx8900\pard\intbl \f0\fs24 "
  Protected TR14.s="{\trowd\trgaph108\trql\cellx3000\cellx6000\cellx9000\cellx12000\cellx15000\pard\intbl \f0\fs24 "
  Protected TR15.s="{\trowd\trgaph108\trql\cellx2100\cellx4500\cellx6900\cellx9300\cellx11700\cellx14100\pard\intbl \f0\fs24 "

  Protected SF_1.s, SF_2.s, SF_3.s, SF_4.s, SF_5.s
  Protected MF_1.s, MF_2.s, MF_3.s, MF_4.s, MF_5.s  
  Protected CS_1.s, CS_2.s, CS_3.s, CS_4.s, CS_5.s
  Protected SG_1.s, SG_2.s, SG_3.s, SG_4.s, SG_5.s
  Protected TM_1.s, TM_2.s, TM_3.s, TM_4.s, TM_5.s
  Protected TR_1.s, TR_2.s, TR_3.s, TR_4.s, TR_5.s
  Protected HR_1.s, HR_2.s, HR_3.s, HR_4.s, HR_5.s
  Protected UR_1.s, UR_2.s, UR_3.s, UR_4.s, UR_5.s
  Protected DRP_1.s, DRP_2.s, DRP_3.s, DRP_4.s, DRP_5.s
  Protected R12_1.s, R12_2.s, R12_3.s, R12_4.s, R12_5.s
  Protected R12A_1.s, R12A_2.s, R12A_3.s, R12A_4.s, R12A_5.s
  Protected RE_1.s, RE_2.s, RE_3.s, RE_4.s, RE_5.s
  Protected Caption.s
  Protected NewMap Unit.Units()
  Protected Is_Name_of_Structure_1.b=#False, Is_Name_of_Structure_2.b=#False, Is_Name_of_Structure_3.b=#False, Is_Name_of_Structure_4.b=#False, Is_Name_of_Structure_5.b=#False
  Protected Max_Char_Column.i
  Protected Number_of_Spaces_to_Insert.i
  Protected Zeile.i
  Protected i.i
  
  ClearList(RTF.s())
  ;ClearGadgetItems(#Editor)
  
  If GetGadgetState(#SI_Units)=#PB_Checkbox_Checked  
    CopyMap(SI_Units(),Unit())
  Else
    CopyMap(Units(),Unit())
  EndIf
  
  If ListSize(Sum_Formula_1.Summenformel())
    ForEach Sum_Formula_1.Summenformel()
      SF_1.s = SF_1.s + Sum_Formula_1.Summenformel()\Elemente + "{\sub " + Sum_Formula_1.Summenformel()\Anzahl + "}"
      SF_1.s = RemoveString(SF_1.s,"{\sub " +"}")
    Next
  EndIf
  
  If ListSize(Sum_Formula_2.Summenformel())
    ForEach Sum_Formula_2.Summenformel()
      SF_2.s = SF_2.s + Sum_Formula_2.Summenformel()\Elemente + "{\sub " + Sum_Formula_2.Summenformel()\Anzahl + "}"
      SF_2.s = RemoveString(SF_2.s,"{\sub " +"}")
    Next
  EndIf
  
  If ListSize(Sum_Formula_3.Summenformel())
    ForEach Sum_Formula_3.Summenformel()
      SF_3.s = SF_3.s + Sum_Formula_3.Summenformel()\Elemente + "{\sub " + Sum_Formula_3.Summenformel()\Anzahl + "}"
      SF_3.s = RemoveString(SF_3.s,"{\sub " +"}")
    Next
  EndIf
  
  If ListSize(Sum_Formula_4.Summenformel())
    ForEach Sum_Formula_4.Summenformel()
      SF_4.s = SF_4.s + Sum_Formula_4.Summenformel()\Elemente + "{\sub " + Sum_Formula_4.Summenformel()\Anzahl + "}"
      SF_4.s = RemoveString(SF_4.s,"{\sub " +"}")
    Next
  EndIf
  
  If ListSize(Sum_Formula_5.Summenformel())
    ForEach Sum_Formula_5.Summenformel()
      SF_5.s = SF_5.s + Sum_Formula_5.Summenformel()\Elemente + "{\sub " + Sum_Formula_5.Summenformel()\Anzahl + "}"
      SF_5.s = RemoveString(SF_5.s,"{\sub " +"}")
    Next
  EndIf

  If ListSize(Moiety_Formula_1.Moietyformel())
    ForEach Moiety_Formula_1.Moietyformel()
      MF_1.s = MF_1.s + Moiety_Formula_1.Moietyformel()\Aufklammer + Moiety_Formula_1.Moietyformel()\Elemente + "{\sub " + Moiety_Formula_1.Moietyformel()\Anzahl + "}" + "{\super " + Moiety_Formula_1.Moietyformel()\Ladung + "}" +  Moiety_Formula_1.Moietyformel()\Zuklammer + Moiety_Formula_1.Moietyformel()\Trennung
      MF_1.s = ReplaceString(MF_1.s," )", ")")
      MF_1.s = RemoveString(MF_1.s,"{\sub " +"}")
      MF_1.s = RemoveString(MF_1.s,"{\super "+"}")
    Next
  EndIf  
  
  If ListSize(Moiety_Formula_2.Moietyformel())
    ForEach Moiety_Formula_2.Moietyformel()
      MF_2.s = MF_2.s + Moiety_Formula_2.Moietyformel()\Aufklammer + Moiety_Formula_2.Moietyformel()\Elemente + "{\sub " +  Moiety_Formula_2.Moietyformel()\Anzahl + "}" + "{\super " + Moiety_Formula_2.Moietyformel()\Ladung + "}" + Moiety_Formula_2.Moietyformel()\Zuklammer + Moiety_Formula_2.Moietyformel()\Trennung
      MF_2.s = ReplaceString(MF_2.s," )", ")")
      MF_2.s = RemoveString(MF_2.s,"{\sub " +"}")
      MF_2.s = RemoveString(MF_2.s,"{\super "+"}")
    Next
  EndIf  
  
  If ListSize(Moiety_Formula_3.Moietyformel())
    ForEach Moiety_Formula_3.Moietyformel()
      MF_3.s = MF_3.s + Moiety_Formula_3.Moietyformel()\Aufklammer + Moiety_Formula_3.Moietyformel()\Elemente + "{\sub " + Moiety_Formula_3.Moietyformel()\Anzahl + "}" + "{\super " + Moiety_Formula_3.Moietyformel()\Ladung + "}" + Moiety_Formula_3.Moietyformel()\Zuklammer + Moiety_Formula_3.Moietyformel()\Trennung
      MF_3.s = ReplaceString(MF_3.s," )", ")")
      MF_3.s = RemoveString(MF_3.s,"{\sub " +"}")
      MF_3.s = RemoveString(MF_3.s,"{\super "+"}")
    Next
  EndIf 
  
  If ListSize(Moiety_Formula_4.Moietyformel())
    ForEach Moiety_Formula_4.Moietyformel()
      MF_4.s = MF_4.s+ Moiety_Formula_4.Moietyformel()\Aufklammer + Moiety_Formula_4.Moietyformel()\Elemente + "{\sub " + Moiety_Formula_4.Moietyformel()\Anzahl + "}" + "{\super " + Moiety_Formula_4.Moietyformel()\Ladung + "}" + Moiety_Formula_4.Moietyformel()\Zuklammer + Moiety_Formula_4.Moietyformel()\Trennung
      MF_4.s = ReplaceString(MF_4.s," )", ")")
      MF_4.s = RemoveString(MF_4.s,"{\sub " +"}")
      MF_4.s = RemoveString(MF_4.s,"{\super "+"}")
    Next
  EndIf  
  
  If ListSize(Moiety_Formula_5.Moietyformel())
    ForEach Moiety_Formula_5.Moietyformel()
      MF_5.s = MF_5.s + Moiety_Formula_5.Moietyformel()\Aufklammer + Moiety_Formula_5.Moietyformel()\Elemente + "{\sub " + Moiety_Formula_5.Moietyformel()\Anzahl + "}" + "{\super " + Moiety_Formula_5.Moietyformel()\Ladung + "}" + Moiety_Formula_5.Moietyformel()\Zuklammer + Moiety_Formula_5.Moietyformel()\Trennung
      MF_5.s = ReplaceString(MF_5.s," )", ")")
      MF_5.s = RemoveString(MF_5.s,"{\sub " +"}")
      MF_5.s = RemoveString(MF_5.s,"{\super "+"}")
    Next
  EndIf 
  
;   Debug "1: " + MF_1.s
;   Debug "2: " + MF_2.s
;   Debug "3: " + MF_3.s
;   Debug "4: " + MF_4.s
;   Debug "5: " + MF_5.s
  
  CS_1.s = CIF_Items_1.s("_exptl_crystal_size_max") + " x " + CIF_Items_1.s("_exptl_crystal_size_mid") + " x " + CIF_Items_1.s("_exptl_crystal_size_min") 
  CS_2.s = CIF_Items_2.s("_exptl_crystal_size_max") + " x " + CIF_Items_2.s("_exptl_crystal_size_mid") + " x " + CIF_Items_2.s("_exptl_crystal_size_min") 
  CS_3.s = CIF_Items_3.s("_exptl_crystal_size_max") + " x " + CIF_Items_3.s("_exptl_crystal_size_mid") + " x " + CIF_Items_3.s("_exptl_crystal_size_min")
  CS_4.s = CIF_Items_4.s("_exptl_crystal_size_max") + " x " + CIF_Items_4.s("_exptl_crystal_size_mid") + " x " + CIF_Items_4.s("_exptl_crystal_size_min")
  CS_5.s = CIF_Items_5.s("_exptl_crystal_size_max") + " x " + CIF_Items_5.s("_exptl_crystal_size_mid") + " x " + CIF_Items_5.s("_exptl_crystal_size_min")
  
  If CS_1.s=" x  x " : CS_1.s="" : EndIf
  If CS_2.s=" x  x " : CS_2.s="" : EndIf
  If CS_3.s=" x  x " : CS_3.s="" : EndIf
  If CS_4.s=" x  x " : CS_4.s="" : EndIf
  If CS_5.s=" x  x " : CS_5.s="" : EndIf
   
  SG_1.s = SPG_Dict_RTF(RemoveString(Trim(CIF_Items_1.s("_space_group_name_H-M_alt"),"'")," ")) +  " (No. " + CIF_Items_1.s("_space_group_IT_number") + ")" + SPG_Dict_RTF(RemoveString(Trim(CIF_Items_1.s("_symmetry_space_group_name_H-M"),"'")," ")) 
  SG_2.s = SPG_Dict_RTF(RemoveString(Trim(CIF_Items_2.s("_space_group_name_H-M_alt"),"'")," ")) +  " (No. " + CIF_Items_2.s("_space_group_IT_number") + ")" + SPG_Dict_RTF(RemoveString(Trim(CIF_Items_2.s("_symmetry_space_group_name_H-M"),"'")," ")) 
  SG_3.s = SPG_Dict_RTF(RemoveString(Trim(CIF_Items_3.s("_space_group_name_H-M_alt"),"'")," ")) +  " (No. " + CIF_Items_3.s("_space_group_IT_number") + ")" + SPG_Dict_RTF(RemoveString(Trim(CIF_Items_3.s("_symmetry_space_group_name_H-M"),"'")," ")) 
  SG_4.s = SPG_Dict_RTF(RemoveString(Trim(CIF_Items_4.s("_space_group_name_H-M_alt"),"'")," ")) +  " (No. " + CIF_Items_4.s("_space_group_IT_number") + ")" + SPG_Dict_RTF(RemoveString(Trim(CIF_Items_4.s("_symmetry_space_group_name_H-M"),"'")," ")) 
  SG_5.s = SPG_Dict_RTF(RemoveString(Trim(CIF_Items_5.s("_space_group_name_H-M_alt"),"'")," ")) +  " (No. " + CIF_Items_5.s("_space_group_IT_number") + ")" + SPG_Dict_RTF(RemoveString(Trim(CIF_Items_5.s("_symmetry_space_group_name_H-M"),"'")," ")) 
  
  SG_1.s = RemoveString(SG_1.s," (No. " + ")")
  SG_2.s = RemoveString(SG_2.s," (No. " + ")")
  SG_3.s = RemoveString(SG_3.s," (No. " + ")")
  SG_4.s = RemoveString(SG_4.s," (No. " + ")")
  SG_5.s = RemoveString(SG_5.s," (No. " + ")")
  
  TM_1.s = CIF_Items_1.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_1.s("_exptl_absorpt_correction_T_max")
  TM_2.s = CIF_Items_2.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_2.s("_exptl_absorpt_correction_T_max")
  TM_3.s = CIF_Items_3.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_3.s("_exptl_absorpt_correction_T_max")
  TM_4.s = CIF_Items_4.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_4.s("_exptl_absorpt_correction_T_max")
  TM_5.s = CIF_Items_5.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_5.s("_exptl_absorpt_correction_T_max")
  
  If TM_1.s=" / " : TM_1.s="" : EndIf
  If TM_2.s=" / " : TM_2.s="" : EndIf
  If TM_3.s=" / " : TM_3.s="" : EndIf
  If TM_4.s=" / " : TM_4.s="" : EndIf
  If TM_5.s=" / " : TM_5.s="" : EndIf
  
  TR_1.s = CIF_Items_1.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_1.s("_diffrn_reflns_theta_max")
  TR_2.s = CIF_Items_2.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_2.s("_diffrn_reflns_theta_max")
  TR_3.s = CIF_Items_3.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_3.s("_diffrn_reflns_theta_max")
  TR_4.s = CIF_Items_4.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_4.s("_diffrn_reflns_theta_max")
  TR_5.s = CIF_Items_5.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_5.s("_diffrn_reflns_theta_max")
  
  If TR_1.s=" - " : TR_1.s="" : EndIf
  If TR_2.s=" - " : TR_2.s="" : EndIf
  If TR_3.s=" - " : TR_3.s="" : EndIf
  If TR_4.s=" - " : TR_4.s="" : EndIf
  If TR_5.s=" - " : TR_5.s="" : EndIf
  
  HR_1.s = HKL_entry_Ascii(CIF_Items_1.s())
  HR_2.s = HKL_entry_Ascii(CIF_Items_2.s())
  HR_3.s = HKL_entry_Ascii(CIF_Items_3.s())
  HR_4.s = HKL_entry_Ascii(CIF_Items_4.s())
  HR_5.s = HKL_entry_Ascii(CIF_Items_5.s())
  
  HR_1.s = Trim(RemoveString(HR_1.s,"±,"))
  HR_2.s = Trim(RemoveString(HR_2.s,"±,"))
  HR_3.s = Trim(RemoveString(HR_3.s,"±,"))
  HR_4.s = Trim(RemoveString(HR_4.s,"±,"))
  HR_5.s = Trim(RemoveString(HR_5.s,"±,"))
  
  If HR_1.s="±" : HR_1.s="" : EndIf
  If HR_2.s="±" : HR_2.s="" : EndIf
  If HR_3.s="±" : HR_3.s="" : EndIf
  If HR_4.s="±" : HR_4.s="" : EndIf
  If HR_5.s="±" : HR_5.s="" : EndIf
  
  UR_1.s = CIF_Items_1.s("_reflns_number_total") + " [" + CIF_Items_1.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_2.s = CIF_Items_2.s("_reflns_number_total") + " [" + CIF_Items_2.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_3.s = CIF_Items_3.s("_reflns_number_total") + " [" + CIF_Items_3.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_4.s = CIF_Items_4.s("_reflns_number_total") + " [" + CIF_Items_4.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_5.s = CIF_Items_5.s("_reflns_number_total") + " [" + CIF_Items_5.s("_diffrn_reflns_av_R_equivalents") + "]"
  
  If UR_1.s=" []" : UR_1.s="" : EndIf
  If UR_2.s=" []" : UR_2.s="" : EndIf
  If UR_3.s=" []" : UR_3.s="" : EndIf
  If UR_4.s=" []" : UR_4.s="" : EndIf
  If UR_5.s=" []" : UR_5.s="" : EndIf
  
  DRP_1.s = CIF_Items_1.s("_reflns_number_total") + " / " + CIF_Items_1.s("_refine_ls_number_restraints")  + " / " + CIF_Items_1.s("_refine_ls_number_parameters")
  DRP_2.s = CIF_Items_2.s("_reflns_number_total") + " / " + CIF_Items_2.s("_refine_ls_number_restraints")  + " / " + CIF_Items_2.s("_refine_ls_number_parameters")
  DRP_3.s = CIF_Items_3.s("_reflns_number_total") + " / " + CIF_Items_3.s("_refine_ls_number_restraints")  + " / " + CIF_Items_3.s("_refine_ls_number_parameters")
  DRP_4.s = CIF_Items_4.s("_reflns_number_total") + " / " + CIF_Items_4.s("_refine_ls_number_restraints")  + " / " + CIF_Items_4.s("_refine_ls_number_parameters")
  DRP_5.s = CIF_Items_5.s("_reflns_number_total") + " / " + CIF_Items_5.s("_refine_ls_number_restraints")  + " / " + CIF_Items_5.s("_refine_ls_number_parameters")
  
  If DRP_1.s=" /  / " : DRP_1.s="" : EndIf
  If DRP_2.s=" /  / " : DRP_2.s="" : EndIf
  If DRP_3.s=" /  / " : DRP_3.s="" : EndIf
  If DRP_4.s=" /  / " : DRP_4.s="" : EndIf
  If DRP_5.s=" /  / " : DRP_5.s="" : EndIf
  
  R12_1.s = CIF_Items_1.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_1.s("_refine_ls_wR_factor_gt")
  R12_2.s = CIF_Items_2.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_2.s("_refine_ls_wR_factor_gt")
  R12_3.s = CIF_Items_3.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_3.s("_refine_ls_wR_factor_gt")
  R12_4.s = CIF_Items_4.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_4.s("_refine_ls_wR_factor_gt")
  R12_5.s = CIF_Items_5.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_5.s("_refine_ls_wR_factor_gt")
  
  If R12_1.s=" / " : R12_1.s="" : EndIf
  If R12_2.s=" / " : R12_2.s="" : EndIf
  If R12_3.s=" / " : R12_3.s="" : EndIf
  If R12_4.s=" / " : R12_4.s="" : EndIf
  If R12_5.s=" / " : R12_5.s="" : EndIf
  
  R12A_1.s = CIF_Items_1.s("_refine_ls_R_factor_all") + " / " + CIF_Items_1.s("_refine_ls_wR_factor_ref")
  R12A_2.s = CIF_Items_2.s("_refine_ls_R_factor_all") + " / " + CIF_Items_2.s("_refine_ls_wR_factor_ref")
  R12A_3.s = CIF_Items_3.s("_refine_ls_R_factor_all") + " / " + CIF_Items_3.s("_refine_ls_wR_factor_ref")
  R12A_4.s = CIF_Items_4.s("_refine_ls_R_factor_all") + " / " + CIF_Items_4.s("_refine_ls_wR_factor_ref")
  R12A_5.s = CIF_Items_5.s("_refine_ls_R_factor_all") + " / " + CIF_Items_5.s("_refine_ls_wR_factor_ref")
  
  If R12A_1.s=" / " : R12A_1.s="" : EndIf
  If R12A_2.s=" / " : R12A_2.s="" : EndIf
  If R12A_3.s=" / " : R12A_3.s="" : EndIf
  If R12A_4.s=" / " : R12A_4.s="" : EndIf
  If R12A_5.s=" / " : R12A_5.s="" : EndIf
  
  RE_1.s = CIF_Items_1.s("_refine_diff_density_min") + " / " + CIF_Items_1.s("_refine_diff_density_max")
  RE_2.s = CIF_Items_2.s("_refine_diff_density_min") + " / " + CIF_Items_2.s("_refine_diff_density_max")
  RE_3.s = CIF_Items_3.s("_refine_diff_density_min") + " / " + CIF_Items_3.s("_refine_diff_density_max")
  RE_4.s = CIF_Items_4.s("_refine_diff_density_min") + " / " + CIF_Items_4.s("_refine_diff_density_max")
  RE_5.s = CIF_Items_5.s("_refine_diff_density_min") + " / " + CIF_Items_5.s("_refine_diff_density_max")
  
  If RE_1.s=" / " : RE_1.s="" : EndIf
  If RE_2.s=" / " : RE_2.s="" : EndIf
  If RE_3.s=" / " : RE_3.s="" : EndIf
  If RE_4.s=" / " : RE_4.s="" : EndIf
  If RE_5.s=" / " : RE_5.s="" : EndIf
 
  If Name_of_Structure_1.s : Is_Name_of_Structure_1.b=#True : EndIf
  If Name_of_Structure_2.s : Is_Name_of_Structure_2.b=#True : EndIf
  If Name_of_Structure_3.s : Is_Name_of_Structure_3.b=#True : EndIf
  If Name_of_Structure_4.s : Is_Name_of_Structure_4.b=#True : EndIf
  If Name_of_Structure_5.s : Is_Name_of_Structure_5.b=#True : EndIf
  
  If Is_Name_of_Structure_1.b And Not Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    If Not Len(SG_1.s) : SG_1.s="?" : EndIf
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    If Not Len(SG_1.s) : SG_1.s="?" : EndIf
    If Not Len(SG_2.s) : SG_2.s="?" : EndIf
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    If Not Len(SG_1.s) : SG_1.s="?" : EndIf
    If Not Len(SG_2.s) : SG_2.s="?" : EndIf
    If Not Len(SG_3.s) : SG_3.s="?" : EndIf
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    If Not Len(SG_1.s) : SG_1.s="?" : EndIf
    If Not Len(SG_2.s) : SG_2.s="?" : EndIf
    If Not Len(SG_3.s) : SG_3.s="?" : EndIf
    If Not Len(SG_4.s) : SG_4.s="?" : EndIf
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Is_Name_of_Structure_5.b
    If Not Len(SG_1.s) : SG_1.s="?" : EndIf
    If Not Len(SG_2.s) : SG_2.s="?" : EndIf
    If Not Len(SG_3.s) : SG_3.s="?" : EndIf
    If Not Len(SG_4.s) : SG_4.s="?" : EndIf
    If Not Len(SG_5.s) : SG_5.s="?" : EndIf
  EndIf

  
  If Is_Name_of_Structure_1.b And Not Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "{\b Table 1.} Crystal data and refinement details for " + "{\b " + Name_of_Structure_1.s + "}" + "." 
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "{\b Table 1.} Crystal data and refinement details for " + "{\b " + Name_of_Structure_1.s + "}" + " and " + "{\b " + Name_of_Structure_2.s + "}" +  "."
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "{\b Table 1.} Crystal data and refinement details for " + "{\b " + Name_of_Structure_1.s + "}" + ", " + "{\b " + Name_of_Structure_2.s + "}" +  ", and " + "{\b " + Name_of_Structure_3.s + "}" + "."
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "{\b Table 1.} Crystal data and refinement details for " + "{\b " + Name_of_Structure_1.s + "}" + ", " + "{\b " + Name_of_Structure_2.s + "}" +  ", " + "{\b " + Name_of_Structure_3.s + "}" + ", and " + "{\b " + Name_of_Structure_4.s + "}" + "."
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Is_Name_of_Structure_5.b
    Caption.s= "{\b Table 1.} Crystal data and refinement details for " + "{\b " + Name_of_Structure_1.s + "}" + ", " + "{\b " + Name_of_Structure_2.s + "}" +  ", " + "{\b " + Name_of_Structure_3.s + "}" + ", " + "{\b " + Name_of_Structure_4.s + "}" + ", and " + "{\b " + Name_of_Structure_5.s + "}" + "."
  EndIf
  
  AddElement(RTF.s()) : RTF.s() = "{\rtf1\ansi\deff0{\fonttbl{\f0 Times New Roman;}{\f1\froman\fprq2\fcharset2{\*\panose 05050102010706020507} Symbol;}}"
  AddElement(RTF.s()) : RTF.s() = "{\colortbl;\red255\green0\blue0;\red0\green0\blue255;}"

  If GetGadgetState(#A4_Auto)
    If Is_Name_of_Structure_1.b And Not Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
      AddElement(RTF.s()) : RTF.s() = "\paperw11909\paperh16834\margl1138\margt562\margr562\margb562"
    ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
      AddElement(RTF.s()) : RTF.s() = "\paperw11909\paperh16834\margl1138\margt562\margr562\margb562"
    ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
      AddElement(RTF.s()) : RTF.s() = "\paperw11909\paperh16834\margl1138\margt562\margr562\margb562"
    ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
      AddElement(RTF.s()) : RTF.s() = "\paperw16834\paperh11909\margl562\margt562\margr562\margb562"
    ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Is_Name_of_Structure_5.b
      AddElement(RTF.s()) : RTF.s() = "\paperw16834\paperh11909\margl562\margt562\margr562\margb562"
    EndIf
  ElseIf GetGadgetState(#A4_Portrait)
    AddElement(RTF.s()) : RTF.s() = "\paperw11909\paperh16834\margl1138\margt562\margr562\margb562"
  ElseIf GetGadgetState(#A4_Landscape)
    AddElement(RTF.s()) : RTF.s() = "\paperw16834\paperh11909\margl562\margt562\margr562\margb562"
  EndIf

  AddElement(RTF.s()) : RTF.s() = "{\pard \f0\fs24 " + Caption.s + "\par}"
  AddElement(RTF.s()) : RTF.s() = Leerzeile_RTF.s
  
  If Is_Name_of_Structure_1.b And Not Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    TR1.s = TR1.s
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    TR1.s = TR12.s
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    TR1.s = TR13.s
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    TR1.s = TR14.s
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Is_Name_of_Structure_5.b
    TR1.s = TR15.s
  EndIf
  
;   Debug "1n: " + MF_1.s
;   Debug "2n: " + MF_2.s
;   Debug "3n: " + MF_3.s
;   Debug "4n: " + MF_4.s
;   Debug "5n: " + MF_5.s
  
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\b compound}" + "TAB1" + "{\b " + Name_of_Structure_1.s + "}" + "TAB2" + "{\b " + Name_of_Structure_2.s + "}" + "TAB3" + "{\b " + Name_of_Structure_3.s + "}" + "TAB4" + "{\b " + Name_of_Structure_4.s + "}" + "TAB5" + "{\b " + Name_of_Structure_5.s + "}" + TR3.s
  
  AddElement(RTF.s()) : RTF.s() = TR1.s + "empirical formula" + "TAB1" + SF_1.s + "TAB2" + SF_2.s + "TAB3" + SF_3.s + "TAB4" + SF_4.s + "TAB5" + SF_5.s + TR3.s
  If GetGadgetState(#Include_Moiety)=#PB_Checkbox_Checked 
    AddElement(RTF.s()) : RTF.s() = TR1.s + "moiety formula" + "TAB1" + MF_1.s + "TAB2" + MF_2.s + "TAB3" + MF_3.s + "TAB4" + MF_4.s + "TAB5" + MF_5.s + TR3.s
  EndIf
  AddElement(RTF.s()) : RTF.s() = TR1.s + "formula weight" + "TAB1" + CIF_Items_1.s("_chemical_formula_weight") +
                                                  "TAB2" + CIF_Items_2.s("_chemical_formula_weight") +
                                                  "TAB3" + CIF_Items_3.s("_chemical_formula_weight") +
                                                  "TAB4" + CIF_Items_4.s("_chemical_formula_weight") +
                                                  "TAB5" + CIF_Items_5.s("_chemical_formula_weight") + TR3.s
  If GetGadgetState(#Include_T)=#PB_Checkbox_Checked 
    AddElement(RTF.s()) : RTF.s() = TR1.s + "{\i T} " + Unit("Kel")\Unit_RTF + "TAB1" + CIF_Items_1.s("_diffrn_ambient_temperature") + 
                                                    "TAB2" + CIF_Items_2.s("_diffrn_ambient_temperature") +
                                                    "TAB3" + CIF_Items_3.s("_diffrn_ambient_temperature") +
                                                    "TAB4" + CIF_Items_4.s("_diffrn_ambient_temperature") +
                                                    "TAB5" + CIF_Items_5.s("_diffrn_ambient_temperature") + TR3.s
  EndIf
  AddElement(RTF.s()) : RTF.s() = TR1.s + "crystal size " + Unit("Siz")\Unit_RTF + "TAB1" + CS_1.s + "TAB2" + CS_2.s + "TAB3" + CS_3.s + "TAB4" + CS_4.s + "TAB5" + CS_5.s   + TR3.s                                         
  AddElement(RTF.s()) : RTF.s() = TR1.s + "crystal system" + "TAB1" + CIF_Items_1.s("_space_group_crystal_system") + CIF_Items_1.s("_symmetry_cell_setting") + 
                                                  "TAB2" + CIF_Items_2.s("_space_group_crystal_system") + CIF_Items_2.s("_symmetry_cell_setting") +
                                                  "TAB3" + CIF_Items_3.s("_space_group_crystal_system") + CIF_Items_3.s("_symmetry_cell_setting") +
                                                  "TAB4" + CIF_Items_4.s("_space_group_crystal_system") + CIF_Items_4.s("_symmetry_cell_setting") +
                                                  "TAB5" + CIF_Items_5.s("_space_group_crystal_system") + CIF_Items_5.s("_symmetry_cell_setting") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "space group" + "TAB1" + SG_1.s + "TAB2" + SG_2.s + "TAB3" + SG_3.s + "TAB4" + SG_4.s + "TAB5" + SG_5.s + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\i a} " + Unit("Ang")\Unit_RTF + "TAB1" + CIF_Items_1.s("_cell_length_a") +
                                                  "TAB2" + CIF_Items_2.s("_cell_length_a") +
                                                  "TAB3" + CIF_Items_3.s("_cell_length_a") +
                                                  "TAB4" + CIF_Items_4.s("_cell_length_a") +
                                                  "TAB5" + CIF_Items_5.s("_cell_length_a") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\i b} " + Unit("Ang")\Unit_RTF + "TAB1" + CIF_Items_1.s("_cell_length_b") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_length_b") +
                                                  "TAB3" + CIF_Items_3.s("_cell_length_b") +
                                                  "TAB4" + CIF_Items_4.s("_cell_length_b") +
                                                  "TAB5" + CIF_Items_5.s("_cell_length_b") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\i c} " + Unit("Ang")\Unit_RTF + "TAB1" + CIF_Items_1.s("_cell_length_c") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_length_c") +
                                                  "TAB3" + CIF_Items_3.s("_cell_length_c") +
                                                  "TAB4" + CIF_Items_4.s("_cell_length_c") +
                                                  "TAB5" + CIF_Items_5.s("_cell_length_c") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\f1\fs24 a} " + Unit("Deg")\Unit_RTF + "TAB1" + CIF_Items_1.s("_cell_angle_alpha") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_angle_alpha") +
                                                  "TAB3" + CIF_Items_3.s("_cell_angle_alpha") +
                                                  "TAB4" + CIF_Items_4.s("_cell_angle_alpha") +
                                                  "TAB5" + CIF_Items_5.s("_cell_angle_alpha") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\f1\fs24 b} " + Unit("Deg")\Unit_RTF + "TAB1" + CIF_Items_1.s("_cell_angle_beta") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_angle_beta") +
                                                  "TAB3" + CIF_Items_3.s("_cell_angle_beta") +
                                                  "TAB4" + CIF_Items_4.s("_cell_angle_beta") +
                                                  "TAB5" + CIF_Items_5.s("_cell_angle_beta") + TR3.s  
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\f1\fs24 g} " + Unit("Deg")\Unit_RTF + "TAB1" + CIF_Items_1.s("_cell_angle_gamma") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_angle_gamma") +
                                                  "TAB3" + CIF_Items_3.s("_cell_angle_gamma") +
                                                  "TAB4" + CIF_Items_4.s("_cell_angle_gamma") +
                                                  "TAB5" + CIF_Items_5.s("_cell_angle_gamma") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\i V} " + Unit("Vol")\Unit_RTF + "TAB1" + CIF_Items_1.s("_cell_volume") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_volume") +
                                                  "TAB3" + CIF_Items_3.s("_cell_volume") +
                                                  "TAB4" + CIF_Items_4.s("_cell_volume") +
                                                  "TAB5" + CIF_Items_5.s("_cell_volume") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\i Z}" + "TAB1" + CIF_Items_1.s("_cell_formula_units_Z") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_formula_units_Z") +
                                                  "TAB3" + CIF_Items_3.s("_cell_formula_units_Z") +
                                                  "TAB4" + CIF_Items_4.s("_cell_formula_units_Z") +
                                                  "TAB5" + CIF_Items_5.s("_cell_formula_units_Z") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\f1\fs24 r} " + Unit("Rho")\Unit_RTF + "TAB1" + CIF_Items_1.s("_exptl_crystal_density_diffrn") + 
                                                  "TAB2" + CIF_Items_2.s("_exptl_crystal_density_diffrn") +
                                                  "TAB3" + CIF_Items_3.s("_exptl_crystal_density_diffrn") +
                                                  "TAB4" + CIF_Items_4.s("_exptl_crystal_density_diffrn") +
                                                  "TAB5" + CIF_Items_5.s("_exptl_crystal_density_diffrn") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\i F}(000)" + "TAB1" + CIF_Items_1.s("_exptl_crystal_F_000") + 
                                                  "TAB2" + CIF_Items_2.s("_exptl_crystal_F_000") +
                                                  "TAB3" + CIF_Items_3.s("_exptl_crystal_F_000") +
                                                  "TAB4" + CIF_Items_4.s("_exptl_crystal_F_000") +
                                                  "TAB5" + CIF_Items_5.s("_exptl_crystal_F_000") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "µ "  + Unit("Abs")\Unit_RTF + "TAB1" + CIF_Items_1.s("_exptl_absorpt_coefficient_mu") + 
                                                  "TAB2" + CIF_Items_2.s("_exptl_absorpt_coefficient_mu") +
                                                  "TAB3" + CIF_Items_3.s("_exptl_absorpt_coefficient_mu") +
                                                  "TAB4" + CIF_Items_4.s("_exptl_absorpt_coefficient_mu") +
                                                  "TAB5" + CIF_Items_5.s("_exptl_absorpt_coefficient_mu") + TR3.s

  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\i T}{\sub min} / {\i T}{\sub max}" + "TAB1" + TM_1.s + "TAB2" + TM_2.s + "TAB3" + TM_3.s + "TAB4" + TM_4.s + "TAB5" + TM_5.s + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\f1\fs24 q}-range " + Unit("Deg")\Unit_RTF + "TAB1" + TR_1.s + "TAB2" + TR_2.s + "TAB3" + TR_3.s + "TAB4" + TR_4.s + "TAB5" + TR_5.s + TR3.s
  
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\i hkl}-range" + "TAB1" + HR_1.s + "TAB2" + HR_2.s + "TAB3" + HR_3.s + "TAB4" + HR_4.s + "TAB5" + HR_5.s + TR3.s
  
  AddElement(RTF.s()) : RTF.s() = TR1.s + "measured refl." + "TAB1" + CIF_Items_1.s("_diffrn_reflns_number") + 
                                                  "TAB2" + CIF_Items_2.s("_diffrn_reflns_number") +
                                                  "TAB3" + CIF_Items_3.s("_diffrn_reflns_number") +
                                                  "TAB4" + CIF_Items_4.s("_diffrn_reflns_number") +
                                                  "TAB5" + CIF_Items_5.s("_diffrn_reflns_number") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "unique refl. [{\i R}{\sub int}]" + "TAB1" + UR_1.s + "TAB2" + UR_2.s + "TAB3" + UR_3.s + "TAB4" + UR_4.s + "TAB5" + UR_5.s + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "observed refl. ({\i I} > 2{\f1\fs24 s}({\i I}))" + "TAB1" + CIF_Items_1.s("_reflns_number_gt") + 
                                                  "TAB2" + CIF_Items_2.s("_reflns_number_gt") +
                                                  "TAB3" + CIF_Items_3.s("_reflns_number_gt") +
                                                  "TAB4" + CIF_Items_4.s("_reflns_number_gt") +
                                                  "TAB5" + CIF_Items_5.s("_reflns_number_gt") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "data / restr. / param." + "TAB1" + DRP_1.s + "TAB2" + DRP_2.s + "TAB3" + DRP_3.s + "TAB4" + DRP_4.s + "TAB5" + DRP_5.s + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "goodness-of-fit ({\i F}²)"  + "TAB1" + CIF_Items_1.s("_refine_ls_goodness_of_fit_ref") + 
                                                  "TAB2" + CIF_Items_2.s("_refine_ls_goodness_of_fit_ref") +
                                                  "TAB3" + CIF_Items_3.s("_refine_ls_goodness_of_fit_ref") +
                                                  "TAB4" + CIF_Items_4.s("_refine_ls_goodness_of_fit_ref") +
                                                  "TAB5" + CIF_Items_5.s("_refine_ls_goodness_of_fit_ref") + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\i R}1, {\i wR}2 ({\i I} > 2{\f1\fs24 s}({\i I}))" + "TAB1" + R12_1.s + "TAB2" + R12_2.s + "TAB3" + R12_3.s + "TAB4" + R12_4.s + "TAB5" + R12_5.s + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "{\i R}1, {\i wR}2 (all data)"  + "TAB1" + R12A_1.s + "TAB2" + R12A_2.s + "TAB3" + R12A_3.s + "TAB4" + R12A_4.s + "TAB5" + R12A_5.s + TR3.s
  AddElement(RTF.s()) : RTF.s() = TR1.s + "res. el. dens. "  + Unit("Red")\Unit_RTF + "TAB1" + RE_1.s + "TAB2" + RE_2.s + "TAB3" + RE_3.s + "TAB4" + RE_4.s + "TAB5" + RE_5.s + TR3.s
  AddElement(RTF.s()) : RTF.s() = Leerzeile_RTF.s
  AddElement(RTF.s()) : RTF.s() = "}"
  
  ForEach RTF.s()
    RTF.s()=ReplaceString(RTF.s(),"TAB1", TR2.s)
    RTF.s()=ReplaceString(RTF.s(),"TAB2", TR2.s)
    RTF.s()=ReplaceString(RTF.s(),"TAB3", TR2.s)
    RTF.s()=ReplaceString(RTF.s(),"TAB4", TR2.s)
    RTF.s()=ReplaceString(RTF.s(),"TAB5", TR2.s)
    RTF.s()=RemoveString(RTF.s(),"{\b }")
    RTF.s()=RemoveString(RTF.s(), TR2.s + TR2.s + TR2.s + TR2.s)
    RTF.s()=RemoveString(RTF.s(), TR2.s + TR2.s + TR2.s)
    RTF.s()=RemoveString(RTF.s(), TR2.s + TR2.s)
    RTF.s()=ReplaceString(RTF.s(), TR2.s + TR3.s, TR3.s)
  Next
  
;   
;   ForEach RTF.s()
;     AddGadgetItem(#Editor, Zeile.i, Trim(RTF.s()))
;     Zeile.i=Zeile.i+1
;   Next
  
EndProcedure

Procedure Create_Markdown()
  
  ClearList(MD_Ascii.s())
  ;ClearGadgetItems(#Editor)
  
  Protected HD_1.s, HD_2.s, HD_3.s, HD_4.s, HD_5.s
  Protected SF_1.s, SF_2.s, SF_3.s, SF_4.s, SF_5.s
  Protected MF_1.s, MF_2.s, MF_3.s, MF_4.s, MF_5.s  
  Protected CS_1.s, CS_2.s, CS_3.s, CS_4.s, CS_5.s
  Protected SG_1.s, SG_2.s, SG_3.s, SG_4.s, SG_5.s
  Protected TM_1.s, TM_2.s, TM_3.s, TM_4.s, TM_5.s
  Protected TR_1.s, TR_2.s, TR_3.s, TR_4.s, TR_5.s
  Protected HR_1.s, HR_2.s, HR_3.s, HR_4.s, HR_5.s
  Protected UR_1.s, UR_2.s, UR_3.s, UR_4.s, UR_5.s
  Protected DRP_1.s, DRP_2.s, DRP_3.s, DRP_4.s, DRP_5.s
  Protected R12_1.s, R12_2.s, R12_3.s, R12_4.s, R12_5.s
  Protected R12A_1.s, R12A_2.s, R12A_3.s, R12A_4.s, R12A_5.s
  Protected RE_1.s, RE_2.s, RE_3.s, RE_4.s, RE_5.s
  Protected Caption.s
  Protected NewMap Unit.Units()
  Protected Is_Name_of_Structure_1.b=#False, Is_Name_of_Structure_2.b=#False, Is_Name_of_Structure_3.b=#False, Is_Name_of_Structure_4.b=#False, Is_Name_of_Structure_5.b=#False
  Protected Max_Char_Column.i
  Protected Number_of_Spaces_to_Insert.i
  Protected Zeile.i
  Protected i.i
  Protected Current_Element.s
  
  If GetGadgetState(#SI_Units)=#PB_Checkbox_Checked  
    CopyMap(SI_Units(),Unit())
  Else
    CopyMap(Units(),Unit())
  EndIf
  
  If ListSize(Sum_Formula_1.Summenformel())
    ForEach Sum_Formula_1.Summenformel()
      SF_1.s = SF_1.s + Sum_Formula_1.Summenformel()\Elemente + "~" +   Sum_Formula_1.Summenformel()\Anzahl + "~" 
    Next
    SF_1.s = RemoveString(SF_1.s,"~~")
  EndIf
  
  If ListSize(Sum_Formula_2.Summenformel())
    ForEach Sum_Formula_2.Summenformel()
      SF_2.s = SF_2.s + Sum_Formula_2.Summenformel()\Elemente + "~" + Sum_Formula_2.Summenformel()\Anzahl + "~" 
    Next
    SF_2.s = RemoveString(SF_2.s,"~~")
  EndIf
  
  If ListSize(Sum_Formula_3.Summenformel())
    ForEach Sum_Formula_3.Summenformel()
      SF_3.s = SF_3.s + Sum_Formula_3.Summenformel()\Elemente + "~" + Sum_Formula_3.Summenformel()\Anzahl + "~" 
    Next
    SF_3.s = RemoveString(SF_3.s,"~~")
  EndIf
  
  If ListSize(Sum_Formula_4.Summenformel())
    ForEach Sum_Formula_4.Summenformel()
      SF_4.s = SF_4.s + Sum_Formula_4.Summenformel()\Elemente + "~" + Sum_Formula_4.Summenformel()\Anzahl + "~" 
    Next
    SF_4.s = RemoveString(SF_4.s,"~~")
  EndIf
  
  If ListSize(Sum_Formula_5.Summenformel())
    ForEach Sum_Formula_5.Summenformel()
      SF_5.s = SF_5.s + Sum_Formula_5.Summenformel()\Elemente + "~" + Sum_Formula_5.Summenformel()\Anzahl + "~" 
    Next
    SF_5.s = RemoveString(SF_5.s,"~~")
  EndIf

  
  If ListSize(Moiety_Formula_1.Moietyformel())
    ForEach Moiety_Formula_1.Moietyformel()
      MF_1.s = MF_1.s + Moiety_Formula_1.Moietyformel()\Aufklammer + Moiety_Formula_1.Moietyformel()\Elemente + "~" + Moiety_Formula_1.Moietyformel()\Anzahl + "~" + "^" + Moiety_Formula_1.Moietyformel()\Ladung + "^" + Moiety_Formula_1.Moietyformel()\Zuklammer + Moiety_Formula_1.Moietyformel()\Trennung
      MF_1.s = ReplaceString(MF_1.s," )", ")")
      MF_1.s = RemoveString(MF_1.s,"~~")
      MF_1.s = RemoveString(MF_1.s,"^^")
    Next
  EndIf  
  
  If ListSize(Moiety_Formula_2.Moietyformel())
    ForEach Moiety_Formula_2.Moietyformel()
      MF_2.s = MF_2.s + Moiety_Formula_2.Moietyformel()\Aufklammer + Moiety_Formula_2.Moietyformel()\Elemente + "~" + Moiety_Formula_2.Moietyformel()\Anzahl + "~" + "^" + Moiety_Formula_2.Moietyformel()\Ladung + "^" +  Moiety_Formula_2.Moietyformel()\Zuklammer + Moiety_Formula_2.Moietyformel()\Trennung
      MF_2.s = ReplaceString(MF_2.s," )", ")")
      MF_2.s = RemoveString(MF_2.s,"~~")
      MF_2.s = RemoveString(MF_2.s,"^^")
    Next
  EndIf  
  
  If ListSize(Moiety_Formula_3.Moietyformel())
    ForEach Moiety_Formula_3.Moietyformel()
      MF_3.s = MF_3.s + Moiety_Formula_3.Moietyformel()\Aufklammer + Moiety_Formula_3.Moietyformel()\Elemente  + "~" +  Moiety_Formula_3.Moietyformel()\Anzahl + "~" + "^" +  Moiety_Formula_3.Moietyformel()\Ladung + "^" +  Moiety_Formula_3.Moietyformel()\Zuklammer + Moiety_Formula_3.Moietyformel()\Trennung
      MF_3.s = ReplaceString(MF_3.s," )", ")")
      MF_3.s = RemoveString(MF_3.s,"~~")
      MF_3.s = RemoveString(MF_3.s,"^^")
    Next
  EndIf 
  
  If ListSize(Moiety_Formula_4.Moietyformel())
    ForEach Moiety_Formula_4.Moietyformel()
      MF_4.s = MF_4.s+ Moiety_Formula_4.Moietyformel()\Aufklammer + Moiety_Formula_4.Moietyformel()\Elemente  + "~" +  Moiety_Formula_4.Moietyformel()\Anzahl + "~" + "^" +  Moiety_Formula_4.Moietyformel()\Ladung + "^" +  Moiety_Formula_4.Moietyformel()\Zuklammer + Moiety_Formula_4.Moietyformel()\Trennung
      MF_4.s = ReplaceString(MF_4.s," )", ")")
      MF_4.s = RemoveString(MF_4.s,"~~")
      MF_4.s = RemoveString(MF_4.s,"^^")
    Next
  EndIf  
  
  If ListSize(Moiety_Formula_5.Moietyformel())
    ForEach Moiety_Formula_5.Moietyformel()
      MF_5.s = MF_5.s + Moiety_Formula_5.Moietyformel()\Aufklammer + Moiety_Formula_5.Moietyformel()\Elemente  + "~" +  Moiety_Formula_5.Moietyformel()\Anzahl + "~" + "^" +  Moiety_Formula_5.Moietyformel()\Ladung + "^" +  Moiety_Formula_5.Moietyformel()\Zuklammer + Moiety_Formula_5.Moietyformel()\Trennung
      MF_5.s = ReplaceString(MF_5.s," )", ")")
      MF_5.s = RemoveString(MF_5.s,"~~")
      MF_5.s = RemoveString(MF_5.s,"^^")
    Next
  EndIf 
  
  HD_1.s = "**" + Name_of_Structure_1.s + "**" 
  HD_2.s = "**" + Name_of_Structure_2.s + "**" 
  HD_3.s = "**" + Name_of_Structure_3.s + "**"
  HD_4.s = "**" + Name_of_Structure_4.s + "**"
  HD_5.s = "**" + Name_of_Structure_5.s + "**"
  
  If HD_1.s="****" : HD_1.s="" : EndIf
  If HD_2.s="****" : HD_2.s="" : EndIf
  If HD_3.s="****" : HD_3.s="" : EndIf
  If HD_4.s="****" : HD_4.s="" : EndIf
  If HD_5.s="****" : HD_5.s="" : EndIf
  
  CS_1.s = CIF_Items_1.s("_exptl_crystal_size_max") + " x " + CIF_Items_1.s("_exptl_crystal_size_mid") + " x " + CIF_Items_1.s("_exptl_crystal_size_min") 
  CS_2.s = CIF_Items_2.s("_exptl_crystal_size_max") + " x " + CIF_Items_2.s("_exptl_crystal_size_mid") + " x " + CIF_Items_2.s("_exptl_crystal_size_min") 
  CS_3.s = CIF_Items_3.s("_exptl_crystal_size_max") + " x " + CIF_Items_3.s("_exptl_crystal_size_mid") + " x " + CIF_Items_3.s("_exptl_crystal_size_min")
  CS_4.s = CIF_Items_4.s("_exptl_crystal_size_max") + " x " + CIF_Items_4.s("_exptl_crystal_size_mid") + " x " + CIF_Items_4.s("_exptl_crystal_size_min")
  CS_5.s = CIF_Items_5.s("_exptl_crystal_size_max") + " x " + CIF_Items_5.s("_exptl_crystal_size_mid") + " x " + CIF_Items_5.s("_exptl_crystal_size_min")
  
  If CS_1.s=" x  x " : CS_1.s="" : EndIf
  If CS_2.s=" x  x " : CS_2.s="" : EndIf
  If CS_3.s=" x  x " : CS_3.s="" : EndIf
  If CS_4.s=" x  x " : CS_4.s="" : EndIf
  If CS_5.s=" x  x " : CS_5.s="" : EndIf
  
  SG_1.s = SPG_Dict_Markdown_Ascii(RemoveString(Trim(CIF_Items_1.s("_space_group_name_H-M_alt"),"'")," ")) + " (No. " + CIF_Items_1.s("_space_group_IT_number") + ")" + SPG_Dict_Markdown_Ascii(RemoveString(Trim(CIF_Items_1.s("_symmetry_space_group_name_H-M"),"'")," "))
  SG_2.s = SPG_Dict_Markdown_Ascii(RemoveString(Trim(CIF_Items_2.s("_space_group_name_H-M_alt"),"'")," ")) + " (No. " + CIF_Items_2.s("_space_group_IT_number") + ")" + SPG_Dict_Markdown_Ascii(RemoveString(Trim(CIF_Items_2.s("_symmetry_space_group_name_H-M"),"'")," "))
  SG_3.s = SPG_Dict_Markdown_Ascii(RemoveString(Trim(CIF_Items_3.s("_space_group_name_H-M_alt"),"'")," ")) + " (No. " + CIF_Items_3.s("_space_group_IT_number") + ")" + SPG_Dict_Markdown_Ascii(RemoveString(Trim(CIF_Items_3.s("_symmetry_space_group_name_H-M"),"'")," "))
  SG_4.s = SPG_Dict_Markdown_Ascii(RemoveString(Trim(CIF_Items_4.s("_space_group_name_H-M_alt"),"'")," ")) + " (No. " + CIF_Items_4.s("_space_group_IT_number") + ")" + SPG_Dict_Markdown_Ascii(RemoveString(Trim(CIF_Items_4.s("_symmetry_space_group_name_H-M"),"'")," "))
  SG_5.s = SPG_Dict_Markdown_Ascii(RemoveString(Trim(CIF_Items_5.s("_space_group_name_H-M_alt"),"'")," ")) + " (No. " + CIF_Items_5.s("_space_group_IT_number") + ")" + SPG_Dict_Markdown_Ascii(RemoveString(Trim(CIF_Items_5.s("_symmetry_space_group_name_H-M"),"'")," "))
  
  SG_1.s = RemoveString(SG_1.s," (No. " + ")")
  SG_2.s = RemoveString(SG_2.s," (No. " + ")")
  SG_3.s = RemoveString(SG_3.s," (No. " + ")")
  SG_4.s = RemoveString(SG_4.s," (No. " + ")")
  SG_5.s = RemoveString(SG_5.s," (No. " + ")")
  
  TM_1.s = CIF_Items_1.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_1.s("_exptl_absorpt_correction_T_max")
  TM_2.s = CIF_Items_2.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_2.s("_exptl_absorpt_correction_T_max")
  TM_3.s = CIF_Items_3.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_3.s("_exptl_absorpt_correction_T_max")
  TM_4.s = CIF_Items_4.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_4.s("_exptl_absorpt_correction_T_max")
  TM_5.s = CIF_Items_5.s("_exptl_absorpt_correction_T_min") + " / " + CIF_Items_5.s("_exptl_absorpt_correction_T_max")
  
  If TM_1.s=" / " : TM_1.s="" : EndIf
  If TM_2.s=" / " : TM_2.s="" : EndIf
  If TM_3.s=" / " : TM_3.s="" : EndIf
  If TM_4.s=" / " : TM_4.s="" : EndIf
  If TM_5.s=" / " : TM_5.s="" : EndIf
  
  TR_1.s = CIF_Items_1.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_1.s("_diffrn_reflns_theta_max")
  TR_2.s = CIF_Items_2.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_2.s("_diffrn_reflns_theta_max")
  TR_3.s = CIF_Items_3.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_3.s("_diffrn_reflns_theta_max")
  TR_4.s = CIF_Items_4.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_4.s("_diffrn_reflns_theta_max")
  TR_5.s = CIF_Items_5.s("_diffrn_reflns_theta_min") + " - " + CIF_Items_5.s("_diffrn_reflns_theta_max")
  
  If TR_1.s=" - " : TR_1.s="" : EndIf
  If TR_2.s=" - " : TR_2.s="" : EndIf
  If TR_3.s=" - " : TR_3.s="" : EndIf
  If TR_4.s=" - " : TR_4.s="" : EndIf
  If TR_5.s=" - " : TR_5.s="" : EndIf
 
  HR_1.s = HKL_entry_Ascii(CIF_Items_1.s())
  HR_2.s = HKL_entry_Ascii(CIF_Items_2.s())
  HR_3.s = HKL_entry_Ascii(CIF_Items_3.s())
  HR_4.s = HKL_entry_Ascii(CIF_Items_4.s())
  HR_5.s = HKL_entry_Ascii(CIF_Items_5.s())
  
  HR_1.s = Trim(RemoveString(HR_1.s,"±,"))
  HR_2.s = Trim(RemoveString(HR_2.s,"±,"))
  HR_3.s = Trim(RemoveString(HR_3.s,"±,"))
  HR_4.s = Trim(RemoveString(HR_4.s,"±,"))
  HR_5.s = Trim(RemoveString(HR_5.s,"±,"))
  
  If HR_1.s="±" : HR_1.s="" : EndIf
  If HR_2.s="±" : HR_2.s="" : EndIf
  If HR_3.s="±" : HR_3.s="" : EndIf
  If HR_4.s="±" : HR_4.s="" : EndIf
  If HR_5.s="±" : HR_5.s="" : EndIf
  
  UR_1.s = CIF_Items_1.s("_reflns_number_total") + " [" + CIF_Items_1.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_2.s = CIF_Items_2.s("_reflns_number_total") + " [" + CIF_Items_2.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_3.s = CIF_Items_3.s("_reflns_number_total") + " [" + CIF_Items_3.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_4.s = CIF_Items_4.s("_reflns_number_total") + " [" + CIF_Items_4.s("_diffrn_reflns_av_R_equivalents") + "]"
  UR_5.s = CIF_Items_5.s("_reflns_number_total") + " [" + CIF_Items_5.s("_diffrn_reflns_av_R_equivalents") + "]"
  
  If UR_1.s=" []" : UR_1.s="" : EndIf
  If UR_2.s=" []" : UR_2.s="" : EndIf
  If UR_3.s=" []" : UR_3.s="" : EndIf
  If UR_4.s=" []" : UR_4.s="" : EndIf
  If UR_5.s=" []" : UR_5.s="" : EndIf
  
  DRP_1.s = CIF_Items_1.s("_reflns_number_total") + " / " + CIF_Items_1.s("_refine_ls_number_restraints")  + " / " + CIF_Items_1.s("_refine_ls_number_parameters")
  DRP_2.s = CIF_Items_2.s("_reflns_number_total") + " / " + CIF_Items_2.s("_refine_ls_number_restraints")  + " / " + CIF_Items_2.s("_refine_ls_number_parameters")
  DRP_3.s = CIF_Items_3.s("_reflns_number_total") + " / " + CIF_Items_3.s("_refine_ls_number_restraints")  + " / " + CIF_Items_3.s("_refine_ls_number_parameters")
  DRP_4.s = CIF_Items_4.s("_reflns_number_total") + " / " + CIF_Items_4.s("_refine_ls_number_restraints")  + " / " + CIF_Items_4.s("_refine_ls_number_parameters")
  DRP_5.s = CIF_Items_5.s("_reflns_number_total") + " / " + CIF_Items_5.s("_refine_ls_number_restraints")  + " / " + CIF_Items_5.s("_refine_ls_number_parameters")
  
  If DRP_1.s=" /  / " : DRP_1.s="" : EndIf
  If DRP_2.s=" /  / " : DRP_2.s="" : EndIf
  If DRP_3.s=" /  / " : DRP_3.s="" : EndIf
  If DRP_4.s=" /  / " : DRP_4.s="" : EndIf
  If DRP_5.s=" /  / " : DRP_5.s="" : EndIf
  
  R12_1.s = CIF_Items_1.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_1.s("_refine_ls_wR_factor_gt")
  R12_2.s = CIF_Items_2.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_2.s("_refine_ls_wR_factor_gt")
  R12_3.s = CIF_Items_3.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_3.s("_refine_ls_wR_factor_gt")
  R12_4.s = CIF_Items_4.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_4.s("_refine_ls_wR_factor_gt")
  R12_5.s = CIF_Items_5.s("_refine_ls_R_factor_gt") + " / " + CIF_Items_5.s("_refine_ls_wR_factor_gt")
  
  If R12_1.s=" / " : R12_1.s="" : EndIf
  If R12_2.s=" / " : R12_2.s="" : EndIf
  If R12_3.s=" / " : R12_3.s="" : EndIf
  If R12_4.s=" / " : R12_4.s="" : EndIf
  If R12_5.s=" / " : R12_5.s="" : EndIf
  
  R12A_1.s = CIF_Items_1.s("_refine_ls_R_factor_all") + " / " + CIF_Items_1.s("_refine_ls_wR_factor_ref")
  R12A_2.s = CIF_Items_2.s("_refine_ls_R_factor_all") + " / " + CIF_Items_2.s("_refine_ls_wR_factor_ref")
  R12A_3.s = CIF_Items_3.s("_refine_ls_R_factor_all") + " / " + CIF_Items_3.s("_refine_ls_wR_factor_ref")
  R12A_4.s = CIF_Items_4.s("_refine_ls_R_factor_all") + " / " + CIF_Items_4.s("_refine_ls_wR_factor_ref")
  R12A_5.s = CIF_Items_5.s("_refine_ls_R_factor_all") + " / " + CIF_Items_5.s("_refine_ls_wR_factor_ref")
  
  If R12A_1.s=" / " : R12A_1.s="" : EndIf
  If R12A_2.s=" / " : R12A_2.s="" : EndIf
  If R12A_3.s=" / " : R12A_3.s="" : EndIf
  If R12A_4.s=" / " : R12A_4.s="" : EndIf
  If R12A_5.s=" / " : R12A_5.s="" : EndIf
  
  RE_1.s = CIF_Items_1.s("_refine_diff_density_min") + " / " + CIF_Items_1.s("_refine_diff_density_max")
  RE_2.s = CIF_Items_2.s("_refine_diff_density_min") + " / " + CIF_Items_2.s("_refine_diff_density_max")
  RE_3.s = CIF_Items_3.s("_refine_diff_density_min") + " / " + CIF_Items_3.s("_refine_diff_density_max")
  RE_4.s = CIF_Items_4.s("_refine_diff_density_min") + " / " + CIF_Items_4.s("_refine_diff_density_max")
  RE_5.s = CIF_Items_5.s("_refine_diff_density_min") + " / " + CIF_Items_5.s("_refine_diff_density_max")
  
  If RE_1.s=" / " : RE_1.s="" : EndIf
  If RE_2.s=" / " : RE_2.s="" : EndIf
  If RE_3.s=" / " : RE_3.s="" : EndIf
  If RE_4.s=" / " : RE_4.s="" : EndIf
  If RE_5.s=" / " : RE_5.s="" : EndIf
 
  If Name_of_Structure_1.s : Is_Name_of_Structure_1.b=#True : EndIf
  If Name_of_Structure_2.s : Is_Name_of_Structure_2.b=#True : EndIf
  If Name_of_Structure_3.s : Is_Name_of_Structure_3.b=#True : EndIf
  If Name_of_Structure_4.s : Is_Name_of_Structure_4.b=#True : EndIf
  If Name_of_Structure_5.s : Is_Name_of_Structure_5.b=#True : EndIf
  
  If Is_Name_of_Structure_1.b And Not Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    If Not Len(SG_1.s) : SG_1.s="?" : EndIf
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    If Not Len(SG_1.s) : SG_1.s="?" : EndIf
    If Not Len(SG_2.s) : SG_2.s="?" : EndIf
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    If Not Len(SG_1.s) : SG_1.s="?" : EndIf
    If Not Len(SG_2.s) : SG_2.s="?" : EndIf
    If Not Len(SG_3.s) : SG_3.s="?" : EndIf
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    If Not Len(SG_1.s) : SG_1.s="?" : EndIf
    If Not Len(SG_2.s) : SG_2.s="?" : EndIf
    If Not Len(SG_3.s) : SG_3.s="?" : EndIf
    If Not Len(SG_4.s) : SG_4.s="?" : EndIf
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Is_Name_of_Structure_5.b
    If Not Len(SG_1.s) : SG_1.s="?" : EndIf
    If Not Len(SG_2.s) : SG_2.s="?" : EndIf
    If Not Len(SG_3.s) : SG_3.s="?" : EndIf
    If Not Len(SG_4.s) : SG_4.s="?" : EndIf
    If Not Len(SG_5.s) : SG_5.s="?" : EndIf
  EndIf
  
  If Is_Name_of_Structure_1.b And Not Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "**Table 1.** Crystal data and refinement details for " + "**" + Name_of_Structure_1.s + "**" + "." 
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Not Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "**Table 1.** Crystal data and refinement details for " + "**" + Name_of_Structure_1.s + "**" + " and " + "**" + Name_of_Structure_2.s + "**" + "."
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Not Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "**Table 1.** Crystal data and refinement details for " + "**" + Name_of_Structure_1.s + "**" + ", " + "**" + Name_of_Structure_2.s + "**" + ", and " + "**" + Name_of_Structure_3.s + "**" + "."
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Not Is_Name_of_Structure_5.b
    Caption.s= "**Table 1.** Crystal data and refinement details for " + "**" + Name_of_Structure_1.s + "**" + ", " + "**" + Name_of_Structure_2.s + "**" + ", " + "**" + Name_of_Structure_3.s + "**" + ", and " + "**" + Name_of_Structure_4.s + "**" + "."
  ElseIf Is_Name_of_Structure_1.b And Is_Name_of_Structure_2.b And Is_Name_of_Structure_3.b And Is_Name_of_Structure_4.b And Is_Name_of_Structure_5.b
    Caption.s= "**Table 1.** Crystal data and refinement details for " + "**" + Name_of_Structure_1.s + "**" + ", " + "**" + Name_of_Structure_2.s + "**" + ", " + "**" + Name_of_Structure_3.s + "**" + ", " + "**" + Name_of_Structure_4.s + "**" + ", and " + "**" + Name_of_Structure_5.s + "**" + "."
  EndIf

  AddElement(MD_Ascii.s()) : MD_Ascii.s() = Caption.s
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = ""
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|**compound**" + "TAB1" + HD_1.s + "TAB2" + HD_2.s + "TAB3" + HD_3.s + "TAB4" + HD_4.s + "TAB5" + HD_5.s + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|empirical formula" + "TAB1" + SF_1.s + "TAB2" + SF_2.s + "TAB3" + SF_3.s + "TAB4" + SF_4.s + "TAB5" + SF_5.s + "TAB6"
  If GetGadgetState(#Include_Moiety)=#PB_Checkbox_Checked 
    AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|moiety formula" + "TAB1" + MF_1.s + "TAB2" + MF_2.s + "TAB3" + MF_3.s + "TAB4" + MF_4.s + "TAB5" + MF_5.s  + "TAB6"
  EndIf
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|formula weight" + "TAB1" + CIF_Items_1.s("_chemical_formula_weight") + 
                                                  "TAB2" + CIF_Items_2.s("_chemical_formula_weight") +
                                                  "TAB3" + CIF_Items_3.s("_chemical_formula_weight") +
                                                  "TAB4" + CIF_Items_4.s("_chemical_formula_weight") +
                                                  "TAB5" + CIF_Items_5.s("_chemical_formula_weight") + "TAB6"
  If GetGadgetState(#Include_T)=#PB_Checkbox_Checked 
    AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|*T* " + Unit("Kel")\Unit_MD + "TAB1" + CIF_Items_1.s("_diffrn_ambient_temperature") + 
                                                    "TAB2" + CIF_Items_2.s("_diffrn_ambient_temperature") +
                                                    "TAB3" + CIF_Items_3.s("_diffrn_ambient_temperature") +
                                                    "TAB4" + CIF_Items_4.s("_diffrn_ambient_temperature") +
                                                    "TAB5" + CIF_Items_5.s("_diffrn_ambient_temperature") + "TAB6"
  EndIf
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|crystal size " + Unit("Siz")\Unit_MD + "TAB1" + CS_1.s + "TAB2" + CS_2.s + "TAB3" + CS_3.s + "TAB4" + CS_4.s + "TAB5" + CS_5.s  + "TAB6"                                          
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|crystal system" + "TAB1" + CIF_Items_1.s("_space_group_crystal_system") + CIF_Items_1.s("_symmetry_cell_setting") + 
                                                  "TAB2" + CIF_Items_2.s("_space_group_crystal_system") + CIF_Items_2.s("_symmetry_cell_setting") +
                                                  "TAB3" + CIF_Items_3.s("_space_group_crystal_system") + CIF_Items_3.s("_symmetry_cell_setting") +
                                                  "TAB4" + CIF_Items_4.s("_space_group_crystal_system") + CIF_Items_4.s("_symmetry_cell_setting") +
                                                  "TAB5" + CIF_Items_5.s("_space_group_crystal_system") + CIF_Items_5.s("_symmetry_cell_setting")  + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|space group" + "TAB1" + SG_1.s + "TAB2" + SG_2.s + "TAB3" + SG_3.s + "TAB4" + SG_4.s + "TAB5" + SG_5.s  + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|*a* " + Unit("Ang")\Unit_MD + "TAB1" + CIF_Items_1.s("_cell_length_a") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_length_a") +
                                                  "TAB3" + CIF_Items_3.s("_cell_length_a") +
                                                  "TAB4" + CIF_Items_4.s("_cell_length_a") +
                                                  "TAB5" + CIF_Items_5.s("_cell_length_a") + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|*b* " + Unit("Ang")\Unit_MD + "TAB1" + CIF_Items_1.s("_cell_length_b") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_length_b") +
                                                  "TAB3" + CIF_Items_3.s("_cell_length_b") +
                                                  "TAB4" + CIF_Items_4.s("_cell_length_b") +
                                                  "TAB5" + CIF_Items_5.s("_cell_length_b") + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|*c* " + Unit("Ang")\Unit_MD + "TAB1" + CIF_Items_1.s("_cell_length_c") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_length_c") +
                                                  "TAB3" + CIF_Items_3.s("_cell_length_c") +
                                                  "TAB4" + CIF_Items_4.s("_cell_length_c") +
                                                  "TAB5" + CIF_Items_5.s("_cell_length_c") + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|α " + Unit("Deg")\Unit_MD + "TAB1" + CIF_Items_1.s("_cell_angle_alpha") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_angle_alpha") +
                                                  "TAB3" + CIF_Items_3.s("_cell_angle_alpha") +
                                                  "TAB4" + CIF_Items_4.s("_cell_angle_alpha") +
                                                  "TAB5" + CIF_Items_5.s("_cell_angle_alpha") + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|β " + Unit("Deg")\Unit_MD + "TAB1" + CIF_Items_1.s("_cell_angle_beta") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_angle_beta") +
                                                  "TAB3" + CIF_Items_3.s("_cell_angle_beta") +
                                                  "TAB4" + CIF_Items_4.s("_cell_angle_beta") +
                                                  "TAB5" + CIF_Items_5.s("_cell_angle_beta")  + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|γ " + Unit("Deg")\Unit_MD + "TAB1" + CIF_Items_1.s("_cell_angle_gamma") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_angle_gamma") +
                                                  "TAB3" + CIF_Items_3.s("_cell_angle_gamma") +
                                                  "TAB4" + CIF_Items_4.s("_cell_angle_gamma") +
                                                  "TAB5" + CIF_Items_5.s("_cell_angle_gamma") + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|*V* " + Unit("Vol")\Unit_MD + "TAB1" + CIF_Items_1.s("_cell_volume") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_volume") +
                                                  "TAB3" + CIF_Items_3.s("_cell_volume") +
                                                  "TAB4" + CIF_Items_4.s("_cell_volume") +
                                                  "TAB5" + CIF_Items_5.s("_cell_volume") + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|*Z* " + "TAB1" + CIF_Items_1.s("_cell_formula_units_Z") + 
                                                  "TAB2" + CIF_Items_2.s("_cell_formula_units_Z") +
                                                  "TAB3" + CIF_Items_3.s("_cell_formula_units_Z") +
                                                  "TAB4" + CIF_Items_4.s("_cell_formula_units_Z") +
                                                  "TAB5" + CIF_Items_5.s("_cell_formula_units_Z") + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|ρ " + Unit("Rho")\Unit_MD + "TAB1" + CIF_Items_1.s("_exptl_crystal_density_diffrn") + 
                                                  "TAB2" + CIF_Items_2.s("_exptl_crystal_density_diffrn") +
                                                  "TAB3" + CIF_Items_3.s("_exptl_crystal_density_diffrn") +
                                                  "TAB4" + CIF_Items_4.s("_exptl_crystal_density_diffrn") +
                                                  "TAB5" + CIF_Items_5.s("_exptl_crystal_density_diffrn") + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|*F(000)*" + "TAB1" + CIF_Items_1.s("_exptl_crystal_F_000") + 
                                                  "TAB2" + CIF_Items_2.s("_exptl_crystal_F_000") +
                                                  "TAB3" + CIF_Items_3.s("_exptl_crystal_F_000") +
                                                  "TAB4" + CIF_Items_4.s("_exptl_crystal_F_000") +
                                                  "TAB5" + CIF_Items_5.s("_exptl_crystal_F_000") + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|µ " + Unit("Abs")\Unit_MD + "TAB1" + CIF_Items_1.s("_exptl_absorpt_coefficient_mu") + 
                                                  "TAB2" + CIF_Items_2.s("_exptl_absorpt_coefficient_mu") +
                                                  "TAB3" + CIF_Items_3.s("_exptl_absorpt_coefficient_mu") +
                                                  "TAB4" + CIF_Items_4.s("_exptl_absorpt_coefficient_mu") +
                                                  "TAB5" + CIF_Items_5.s("_exptl_absorpt_coefficient_mu") + "TAB6"

  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|*T*~min~ / *T*~max~" + "TAB1" + TM_1.s + "TAB2" + TM_2.s + "TAB3" + TM_3.s + "TAB4" + TM_4.s + "TAB5" + TM_5.s + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|θ-range "  + Unit("Deg")\Unit_MD + "TAB1" + TR_1.s + "TAB2" + TR_2.s + "TAB3" + TR_3.s + "TAB4" + TR_4.s + "TAB5" + TR_5.s + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|*hkl*-range" + "TAB1" + HR_1.s + "TAB2" + HR_2.s + "TAB3" + HR_3.s + "TAB4" + HR_4.s + "TAB5" + HR_5.s + "TAB6"
  
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|measured refl." + "TAB1" + CIF_Items_1.s("_diffrn_reflns_number") + 
                                                  "TAB2" + CIF_Items_2.s("_diffrn_reflns_number") +
                                                  "TAB3" + CIF_Items_3.s("_diffrn_reflns_number") +
                                                  "TAB4" + CIF_Items_4.s("_diffrn_reflns_number") +
                                                  "TAB5" + CIF_Items_5.s("_diffrn_reflns_number") + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|unique refl. [*R*~int~]" + "TAB1" + UR_1.s + "TAB2" + UR_2.s + "TAB3" + UR_3.s + "TAB4" + UR_4.s + "TAB5" + UR_5.s + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|obs. refl. (I > 2σ(I))" + "TAB1" + CIF_Items_1.s("_reflns_number_gt") + 
                                                  "TAB2" + CIF_Items_2.s("_reflns_number_gt") +
                                                  "TAB3" + CIF_Items_3.s("_reflns_number_gt") +
                                                  "TAB4" + CIF_Items_4.s("_reflns_number_gt") +
                                                  "TAB5" + CIF_Items_5.s("_reflns_number_gt") + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|data / restr. / param." + "TAB1" + DRP_1.s + "TAB2" + DRP_2.s + "TAB3" + DRP_3.s + "TAB4" + DRP_4.s + "TAB5" + DRP_5.s + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|goodness-of-fit (*F*²)" + "TAB1" + CIF_Items_1.s("_refine_ls_goodness_of_fit_ref") + 
                                                  "TAB2" + CIF_Items_2.s("_refine_ls_goodness_of_fit_ref") +
                                                  "TAB3" + CIF_Items_3.s("_refine_ls_goodness_of_fit_ref") +
                                                  "TAB4" + CIF_Items_4.s("_refine_ls_goodness_of_fit_ref") +
                                                  "TAB5" + CIF_Items_5.s("_refine_ls_goodness_of_fit_ref") + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|*R*1, *wR*2 (I > 2σ(*I*))" + "TAB1" + R12_1.s + "TAB2" + R12_2.s + "TAB3" + R12_3.s + "TAB4" + R12_4.s + "TAB5" + R12_5.s + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|*R*1, *wR*2 (all data)" + "TAB1" + R12A_1.s + "TAB2" + R12A_2.s + "TAB3" + R12A_3.s + "TAB4" + R12A_4.s + "TAB5" + R12A_5.s + "TAB6"
  AddElement(MD_Ascii.s()) : MD_Ascii.s() = "|res. el. dens. "  + Unit("Red")\Unit_MD + "TAB1" + RE_1.s + "TAB2" + RE_2.s + "TAB3" + RE_3.s + "TAB4" + RE_4.s + "TAB5" + RE_5.s + "TAB6"
  
  ForEach MD_Ascii.s()
    If FindString(MD_Ascii.s(),"TAB1")
      If Len(StringField(MD_Ascii.s(),1,"TAB1")) >  Max_Char_Column.i
        Max_Char_Column.i=Len(StringField(MD_Ascii.s(),1,"TAB1"))
      EndIf
    EndIf
  Next 
  
  ForEach MD_Ascii.s()
    If FindString(MD_Ascii.s(),"TAB1")
      Number_of_Spaces_to_Insert.i = Max_Char_Column.i + 4 - Len(StringField(MD_Ascii.s(),1,"TAB1")) 
      MD_Ascii.s()=ReplaceString(MD_Ascii.s(),"TAB1",Space(Number_of_Spaces_to_Insert.i-1)+"|")
    EndIf
  Next

  ForEach MD_Ascii.s()
    If FindString(MD_Ascii.s(),"TAB2")
      If Len(StringField(MD_Ascii.s(),1,"TAB2")) >  Max_Char_Column.i
        Max_Char_Column.i=Len(StringField(MD_Ascii.s(),1,"TAB2"))
      EndIf
    EndIf
  Next 
  
  ForEach MD_Ascii.s()
    If FindString(MD_Ascii.s(),"TAB2")
      Number_of_Spaces_to_Insert.i = Max_Char_Column.i + 4 - Len(StringField(MD_Ascii.s(),1,"TAB2")) 
      MD_Ascii.s()=ReplaceString(MD_Ascii.s(),"TAB2",Space(Number_of_Spaces_to_Insert.i-1)+"|")
    EndIf
  Next
  
  
  ForEach MD_Ascii.s()
    If FindString(MD_Ascii.s(),"TAB3")
      If Len(StringField(MD_Ascii.s(),1,"TAB3")) >  Max_Char_Column.i
        Max_Char_Column.i=Len(StringField(MD_Ascii.s(),1,"TAB3"))
      EndIf
    EndIf
  Next 
  
  ForEach MD_Ascii.s()
    If FindString(MD_Ascii.s(),"TAB3")
      Number_of_Spaces_to_Insert.i = Max_Char_Column.i + 4 - Len(StringField(MD_Ascii.s(),1,"TAB3")) 
      MD_Ascii.s()=ReplaceString(MD_Ascii.s(),"TAB3",Space(Number_of_Spaces_to_Insert.i-1)+"|")
    EndIf
  Next
  
  ForEach MD_Ascii.s()
    If FindString(MD_Ascii.s(),"TAB4")
      If Len(StringField(MD_Ascii.s(),1,"TAB4")) >  Max_Char_Column.i
        Max_Char_Column.i=Len(StringField(MD_Ascii.s(),1,"TAB4"))
      EndIf
    EndIf
  Next 
  
  ForEach MD_Ascii.s()
    If FindString(MD_Ascii.s(),"TAB4")
      Number_of_Spaces_to_Insert.i = Max_Char_Column.i + 4 - Len(StringField(MD_Ascii.s(),1,"TAB4")) 
      MD_Ascii.s()=ReplaceString(MD_Ascii.s(),"TAB4",Space(Number_of_Spaces_to_Insert.i-1)+"|")
    EndIf
  Next
  
  ForEach MD_Ascii.s()
    If FindString(MD_Ascii.s(),"TAB5")
      If Len(StringField(MD_Ascii.s(),1,"TAB5")) >  Max_Char_Column.i
        Max_Char_Column.i=Len(StringField(MD_Ascii.s(),1,"TAB5"))
      EndIf
    EndIf
  Next 
  
  ForEach MD_Ascii.s()
    If FindString(MD_Ascii.s(),"TAB5")
      Number_of_Spaces_to_Insert.i = Max_Char_Column.i + 4 - Len(StringField(MD_Ascii.s(),1,"TAB5")) 
      MD_Ascii.s()=ReplaceString(MD_Ascii.s(),"TAB5",Space(Number_of_Spaces_to_Insert.i-1)+"|")
    EndIf
  Next
  
    ForEach MD_Ascii.s()
    If FindString(MD_Ascii.s(),"TAB6")
      If Len(StringField(MD_Ascii.s(),1,"TAB6")) >  Max_Char_Column.i
        Max_Char_Column.i=Len(StringField(MD_Ascii.s(),1,"TAB6"))
      EndIf
    EndIf
  Next 
  
  ForEach MD_Ascii.s()
    If FindString(MD_Ascii.s(),"TAB6")
      Number_of_Spaces_to_Insert.i = Max_Char_Column.i + 4 - Len(StringField(MD_Ascii.s(),1,"TAB6")) 
      MD_Ascii.s()=ReplaceString(MD_Ascii.s(),"TAB6",Space(Number_of_Spaces_to_Insert.i-1)+"|")
    EndIf
  Next

  If SelectElement(MD_Ascii.s(), 3)
    Current_Element.s=MD_Ascii.s()
    InsertElement(MD_Ascii.s())
    MD_Ascii.s()="|" + LSet("-",Len(StringField(Current_Element.s,2,"|")),"-")+"|"
    MD_Ascii.s()=MD_Ascii.s()+LSet("-",Len(StringField(Current_Element.s,3,"|")),"-")+"|"
    MD_Ascii.s()=MD_Ascii.s()+LSet("-",Len(StringField(Current_Element.s,4,"|")),"-")+"|"
    MD_Ascii.s()=MD_Ascii.s()+LSet("-",Len(StringField(Current_Element.s,5,"|")),"-")+"|"
    MD_Ascii.s()=MD_Ascii.s()+LSet("-",Len(StringField(Current_Element.s,6,"|")),"-")+"|"
    MD_Ascii.s()=MD_Ascii.s()+LSet("-",Len(StringField(Current_Element.s,7,"|")),"-")+"|"
  EndIf
  
  ForEach MD_Ascii.s()
    MD_Ascii.s()=ReplaceString(MD_Ascii.s(),"|---|---|---|","|",#PB_String_NoCase,1,1)
    MD_Ascii.s()=ReplaceString(MD_Ascii.s(),"|   |   |   |","|",#PB_String_NoCase,1,1)
    MD_Ascii.s()=ReplaceString(MD_Ascii.s(),"|---|---|","|",#PB_String_NoCase,1,1)
    MD_Ascii.s()=ReplaceString(MD_Ascii.s(),"|   |   |","|",#PB_String_NoCase,1,1)
    MD_Ascii.s()=ReplaceString(MD_Ascii.s(),"|---|","|",#PB_String_NoCase,1,1)
    MD_Ascii.s()=ReplaceString(MD_Ascii.s(),"|   |","|",#PB_String_NoCase,1,1)
  Next
  
;   ForEach MD_Ascii.s()
;     AddGadgetItem(#Editor, Zeile.i, Trim(MD_Ascii.s()))
;     Zeile.i=Zeile.i+1
;   Next
  
EndProcedure

Procedure.s HKL_entry_Ascii(Map CIF_Items.s())
  
  Protected h_min.s
  Protected h_max.s
  Protected k_min.s
  Protected k_max.s
  Protected l_min.s
  Protected l_max.s
  Protected Signh.s
  Protected Signk.s
  Protected Signl.s
  Protected hklfline.s
            
  h_min.s=CIF_Items("_diffrn_reflns_limit_h_min")
  h_max.s=CIF_Items("_diffrn_reflns_limit_h_max")
  k_min.s=CIF_Items("_diffrn_reflns_limit_k_min")
  k_max.s=CIF_Items("_diffrn_reflns_limit_k_max")
  l_min.s=CIF_Items("_diffrn_reflns_limit_l_min")
  l_max.s=CIF_Items("_diffrn_reflns_limit_l_max")
  
  If ReplaceString(h_min.s,"-","")=ReplaceString(h_max.s,"-","")
    h_min.s= Chr(177)+ReplaceString(h_min.s,"-","")
    h_max.s=""
    Signh.s=""
  Else
    Signh.s=" to "
  EndIf
  
  If ReplaceString(k_min.s,"-","")=ReplaceString(k_max.s,"-","")
    k_min.s= Chr(177)+ReplaceString(k_min.s,"-","")
    k_max.s=""
    Signk.s=""
  Else
    Signk.s=" to "
  EndIf
  
  If ReplaceString(l_min.s,"-","")=ReplaceString(l_max.s,"-","")
    l_min.s= Chr(177)+ReplaceString(l_min.s,"-","")
    l_max.s=""
    Signl.s=""
  Else
    Signl.s=" to "
  EndIf
  
  hklfline.s= h_min.s + Signh.s + h_max.s + ", " + k_min.s + Signk.s + k_max.s  + ", " + l_min.s + Signl.s + l_max.s
  
  ProcedureReturn hklfline.s
EndProcedure

Procedure Fill_Units_Dict()
  
  SI_Units("Siz")\Unit_Asc="/mm³"
  SI_Units("Siz")\Unit_MD="/mm^3^"
  SI_Units("Siz")\Unit_RTF="/mm³"
  SI_Units("Siz")\Unit_LTX="/mm$^3$"
  
  SI_Units("Kel")\Unit_Asc="/K"
  SI_Units("Kel")\Unit_MD="/K"
  SI_Units("Kel")\Unit_RTF="/K"
  SI_Units("Kel")\Unit_LTX="/K"
  
  SI_Units("Ang")\Unit_Asc="/Å"
  SI_Units("Ang")\Unit_MD="/Å"
  SI_Units("Ang")\Unit_RTF="/Å"
  SI_Units("Ang")\Unit_LTX="/\r{A}"
  
  SI_Units("Deg")\Unit_Asc="/°"
  SI_Units("Deg")\Unit_MD="/°"
  SI_Units("Deg")\Unit_RTF="/°"
  SI_Units("Deg")\Unit_LTX="/$^{\circ}$"
  
  SI_Units("Vol")\Unit_Asc="/Å³"
  SI_Units("Vol")\Unit_MD="/Å³" 
  SI_Units("Vol")\Unit_RTF="/Å³"
  SI_Units("Vol")\Unit_LTX="/\r{A}$^3$" 
  
  SI_Units("Rho")\Unit_Asc="/g·cm⁻³"
  SI_Units("Rho")\Unit_MD="/g·cm^-3^"
  SI_Units("Rho")\Unit_RTF="/g" + Chr(183) + "cm{\super -}³"
  SI_Units("Rho")\Unit_LTX="/g$\cdot$cm$^{-3}$"
  
  SI_Units("Abs")\Unit_Asc="/mm⁻¹"
  SI_Units("Abs")\Unit_MD="/mm^-1^"
  SI_Units("Abs")\Unit_RTF="/mm{\super -1}"
  SI_Units("Abs")\Unit_LTX="/mm$^{-1}$"
  
  SI_Units("Red")\Unit_Asc="/e·Å⁻³"
  SI_Units("Red")\Unit_MD="/e·Å^-3^"
  SI_Units("Red")\Unit_RTF="/e" + Chr(183) + "Å{\super -}³"
  SI_Units("Red")\Unit_LTX="/e$\cdot$\r{A}$^{-3}$"
  
  Units("Siz")\Unit_Asc="[mm³]"
  Units("Siz")\Unit_MD="[mm^3^]"
  Units("Siz")\Unit_RTF="[mm³]"
  Units("Siz")\Unit_LTX="[mm$^3$]"
  
  Units("Kel")\Unit_Asc="[K]"
  Units("Kel")\Unit_MD="[K]"
  Units("Kel")\Unit_RTF="[K]"
  Units("Kel")\Unit_LTX="[K]"
  
  Units("Ang")\Unit_Asc="[Å]"
  Units("Ang")\Unit_MD="[Å]"
  Units("Ang")\Unit_RTF="[Å]"
  Units("Ang")\Unit_LTX="[\r{A}]"
  
  Units("Deg")\Unit_Asc="[°]"
  Units("Deg")\Unit_MD="[°]"
  Units("Deg")\Unit_RTF="[°]"
  Units("Deg")\Unit_LTX="[$^{\circ}$]"
  
  Units("Vol")\Unit_Asc="[Å³]"
  Units("Vol")\Unit_MD="[Å³]"
  Units("Vol")\Unit_RTF="[Å³]"
  Units("Vol")\Unit_LTX="[\r{A}$^3$]"
  
  Units("Rho")\Unit_Asc="[g·cm⁻³]"
  Units("Rho")\Unit_MD="[g·cm^-3^]"
  Units("Rho")\Unit_RTF="[g"+ Chr(183) + "cm{\super -}³]"
  Units("Rho")\Unit_LTX="[g$\cdot$cm$^{-3}$]"
  
  Units("Abs")\Unit_Asc="[mm⁻¹]"
  Units("Abs")\Unit_MD="[mm^-1^]"
  Units("Abs")\Unit_RTF="[mm{\super -1}]"
  Units("Abs")\Unit_LTX="[mm$^{-1}$]"
  
  Units("Red")\Unit_Asc="[e·Å⁻³]"
  Units("Red")\Unit_MD="[e·Å^-3^]"
  Units("Red")\Unit_RTF="[e" + Chr(183) + "Å{\super -}³]"
  Units("Red")\Unit_LTX="[e$\cdot$\r{A}$^{-3}$]"
  
EndProcedure

Procedure Fill_SPG_Dict_RTF()
  SPG_Dict_RTF("P1")="{\i P}1"
  SPG_Dict_RTF("P-1")="{\i P}-1"
  SPG_Dict_RTF("P2")="{\i P}2"
  SPG_Dict_RTF("P21")="{\i P}2{\sub 1}"
  SPG_Dict_RTF("C2")="{\i C}2"
  SPG_Dict_RTF("Pm")="{\i P}{\i m}"
  SPG_Dict_RTF("Pc")="{\i P}{\i c}"
  SPG_Dict_RTF("Cm")="{\i C}{\i m}"
  SPG_Dict_RTF("Cc")="{\i C}{\i c}"
  SPG_Dict_RTF("P2/m")="{\i P}2/{\i m}"
  SPG_Dict_RTF("P21/m")="{\i P}2{\sub 1}/{\i m}"
  SPG_Dict_RTF("C2/m")="{\i C}2/{\i m}"
  SPG_Dict_RTF("P2/c")="{\i P}2/{\i c}"
  SPG_Dict_RTF("P21/c")="{\i P}2{\sub 1}/{\i c}"
  SPG_Dict_RTF("P21/n")="{\i P}2{\sub 1}/{\i n}"
  SPG_Dict_RTF("P21/a")="{\i P}2{\sub 1}/{\i a}"
  SPG_Dict_RTF("C2/c")="{\i C}2/{\i c}"
  SPG_Dict_RTF("P222")="{\i P}222"
  SPG_Dict_RTF("P2221")="{\i P}222{\sub 1}"
  SPG_Dict_RTF("P21212")="{\i P}2{\sub 1}2{\sub 1}2"
  SPG_Dict_RTF("P212121")="{\i P}2{\sub 1}2{\sub 1}2{\sub 1}"
  SPG_Dict_RTF("C2221")="{\i C}222{\sub 1}"
  SPG_Dict_RTF("C222")="{\i C}222"
  SPG_Dict_RTF("F222")="{\i F}222"
  SPG_Dict_RTF("I222")="{\i I}222"
  SPG_Dict_RTF("I212121")="{\i I}2{\sub 1}2{\sub 1}2{\sub 1}"
  SPG_Dict_RTF("Pmm2")="{\i P}{\i m}{\i m}2"
  SPG_Dict_RTF("Pmc21")="{\i P}{\i m}{\i c}2{\sub 1}"
  SPG_Dict_RTF("Pcc2")="{\i P}{\i c}{\i c}2"
  SPG_Dict_RTF("Pma2")="{\i P}{\i m}{\i a}2"
  SPG_Dict_RTF("Pca21")="{\i P}{\i c}{\i a}2{\sub 1}"
  SPG_Dict_RTF("Pnc2")="{\i P}{\i n}{\i c}2"
  SPG_Dict_RTF("Pmn21")="{\i P}{\i m}{\i n}2{\sub 1}"
  SPG_Dict_RTF("Pba2")="{\i P}{\i b}{\i a}2"
  SPG_Dict_RTF("Pna21")="{\i P}{\i n}{\i a}2{\sub 1}"
  SPG_Dict_RTF("Pnn2")="{\i P}{\i n}{\i n}2"
  SPG_Dict_RTF("Cmm2")="{\i C}{\i m}{\i m}2"
  SPG_Dict_RTF("Cmc21")="{\i C}{\i m}{\i c}2{\sub 1}"
  SPG_Dict_RTF("Ccc2")="{\i C}{\i c}{\i c}2"
  SPG_Dict_RTF("Amm2")="{\i A}{\i m}{\i m}2"
  SPG_Dict_RTF("Abm2")="{\i A}{\i b}{\i m}2"
  SPG_Dict_RTF("Ama2")="{\i A}{\i m}{\i a}2"
  SPG_Dict_RTF("Aba2")="{\i A}{\i b}{\i a}2"
  SPG_Dict_RTF("Fmm2")="{\i F}{\i m}{\i m}2"
  SPG_Dict_RTF("Fdd2")="{\i F}{\i d}{\i d}2"
  SPG_Dict_RTF("Imm2")="{\i I}{\i m}{\i m}2"
  SPG_Dict_RTF("Iba2")="{\i I}{\i b}{\i a}2"
  SPG_Dict_RTF("Ima2")="{\i I}{\i m}{\i a}2"
  SPG_Dict_RTF("Pmmm")="{\i P}{\i m}{\i m}{\i m}"
  SPG_Dict_RTF("Pnnn")="{\i P}{\i n}{\i n}{\i n}"
  SPG_Dict_RTF("Pccm")="{\i P}{\i c}{\i c}{\i m}"
  SPG_Dict_RTF("Pban")="{\i P}{\i b}{\i a}{\i n}"
  SPG_Dict_RTF("Pmma")="{\i P}{\i m}{\i m}{\i a}"
  SPG_Dict_RTF("Pnna")="{\i P}{\i n}{\i n}{\i a}"
  SPG_Dict_RTF("Pmna")="{\i P}{\i m}{\i n}{\i a}"
  SPG_Dict_RTF("Pcca")="{\i P}{\i c}{\i c}{\i a}"
  SPG_Dict_RTF("Pbam")="{\i P}{\i b}{\i a}{\i m}"
  SPG_Dict_RTF("Pccn")="{\i P}{\i c}{\i c}{\i n}"
  SPG_Dict_RTF("Pbcm")="{\i P}{\i b}{\i c}{\i m}"
  SPG_Dict_RTF("Pnnm")="{\i P}{\i n}{\i n}{\i m}"
  SPG_Dict_RTF("Pmmn")="{\i P}{\i m}{\i m}{\i n}"
  SPG_Dict_RTF("Pbcn")="{\i P}{\i b}{\i c}{\i n}"
  SPG_Dict_RTF("Pbca")="{\i P}{\i b}{\i c}{\i a}"
  SPG_Dict_RTF("Pnma")="{\i P}{\i n}{\i m}{\i a}"
  SPG_Dict_RTF("Cmcm")="{\i C}{\i m}{\i c}{\i m}"
  SPG_Dict_RTF("Cmca")="{\i C}{\i m}{\i c}{\i a}"
  SPG_Dict_RTF("Cmmm")="{\i C}{\i m}{\i m}{\i m}"
  SPG_Dict_RTF("Cccm")="{\i C}{\i c}{\i c}{\i m}"
  SPG_Dict_RTF("Cmma")="{\i C}{\i m}{\i m}{\i a}"
  SPG_Dict_RTF("Ccca")="{\i C}{\i c}{\i c}{\i a}"
  SPG_Dict_RTF("Fmmm")="{\i F}{\i m}{\i m}{\i m}"
  SPG_Dict_RTF("Fddd")="{\i F}{\i d}{\i d}{\i d}"
  SPG_Dict_RTF("Immm")="{\i I}{\i m}{\i m}{\i m}"
  SPG_Dict_RTF("Ibam")="{\i I}{\i b}{\i a}{\i m}"
  SPG_Dict_RTF("Ibca")="{\i I}{\i b}{\i c}{\i a}"
  SPG_Dict_RTF("Imma")="{\i I}{\i m}{\i m}{\i a}"
  SPG_Dict_RTF("P4")="{\i P}4"
  SPG_Dict_RTF("P41")="{\i P}4{\sub 1}"
  SPG_Dict_RTF("P42")="{\i P}4{\sub 2}"
  SPG_Dict_RTF("P43")="{\i P}4{\sub 3}"
  SPG_Dict_RTF("I4")="{\i I}4"
  SPG_Dict_RTF("I41")="{\i I}4{\sub 1}"
  SPG_Dict_RTF("P-4")="{\i P}-4"
  SPG_Dict_RTF("I-4")="{\i I}-4"
  SPG_Dict_RTF("P4/m")="{\i P}4/{\i m}"
  SPG_Dict_RTF("P42/m")="{\i P}4{\sub 2}/{\i m}"
  SPG_Dict_RTF("P4/n")="{\i P}4/{\i n}"
  SPG_Dict_RTF("P42/n")="{\i P}4{\sub 2}/{\i n}"
  SPG_Dict_RTF("I4/m")="{\i I}4/{\i m}"
  SPG_Dict_RTF("I41/a")="{\i I}4{\sub 1}/{\i a}"
  SPG_Dict_RTF("P422")="{\i P}422"
  SPG_Dict_RTF("P4212")="{\i P}42{\sub 1}2"
  SPG_Dict_RTF("P4122")="{\i P}4{\sub 1}22"
  SPG_Dict_RTF("P41212")="{\i P}4{\sub 1}2{\sub 1}2"
  SPG_Dict_RTF("P4222")="{\i P}4{\sub 2}22"
  SPG_Dict_RTF("P42212")="{\i P}4{\sub 2}2{\sub 2}2"
  SPG_Dict_RTF("P4322")="{\i P}4{\sub 3}22"
  SPG_Dict_RTF("P43212")="{\i P}4{\sub 3}2{\sub 1}2"
  SPG_Dict_RTF("I422")="{\i I}422"
  SPG_Dict_RTF("I4122")="{\i I}4{\sub 1}22"
  SPG_Dict_RTF("P4mm")="{\i P}4{\i m}{\i m}"
  SPG_Dict_RTF("P4bm")="{\i P}4{\i b}{\i m}"
  SPG_Dict_RTF("P42cm")="{\i P}4{\sub 2}{\i c}{\i m}"
  SPG_Dict_RTF("P42nm")="{\i P}4{\sub 2}{\i n}{\i m}"
  SPG_Dict_RTF("P4cc")="{\i P}4{\i c}{\i c}"
  SPG_Dict_RTF("P4nc")="{\i P}4{\i n}{\i c}"
  SPG_Dict_RTF("P42mc")="{\i P}4{\sub 2}{\i m}{\i c}"
  SPG_Dict_RTF("P42bc")="{\i P}4{\sub 2}{\i b}{\i c}"
  SPG_Dict_RTF("I4mm")="{\i I}4{\i m}{\i m}"
  SPG_Dict_RTF("I4cm")="{\i I}4{\i c}{\i m}"
  SPG_Dict_RTF("I41md")="{\i I}4{\sub 1}{\i m}{\i d}"
  SPG_Dict_RTF("I41cd")="{\i I}4{\sub 1}{\i c}{\i d}"
  SPG_Dict_RTF("P-42m")="{\i P}-42{\i m}"
  SPG_Dict_RTF("P-42c")="{\i P}-42{\i c}"
  SPG_Dict_RTF("P-421m")="{\i P}-42{\sub 1}{\i m}"
  SPG_Dict_RTF("P-421c")="{\i P}-42{\sub 1}{\i c}"
  SPG_Dict_RTF("P-4m2")="{\i P}-4{\i m}2"
  SPG_Dict_RTF("P-4c2")="{\i P}-4{\i c}2"
  SPG_Dict_RTF("P-4b2")="{\i P}-4{\i b}2"
  SPG_Dict_RTF("P-4n2")="{\i P}-4{\i n}2"
  SPG_Dict_RTF("I-4m2")="{\i I}-4{\i m}2"
  SPG_Dict_RTF("I-4c2")="{\i I}-4{\i c}2"
  SPG_Dict_RTF("I-42m")="{\i I}-42{\i m}"
  SPG_Dict_RTF("I-42d")="{\i I}-42{\i d}"
  SPG_Dict_RTF("P4/mmm")="{\i P}4/{\i m}{\i m}{\i m}"
  SPG_Dict_RTF("P4/mcc")="{\i P}4/{\i m}{\i c}{\i c}"
  SPG_Dict_RTF("P4/nbm")="{\i P}4/{\i n}{\i b}{\i m}"
  SPG_Dict_RTF("P4/nnc")="{\i P}4/{\i n}{\i n}{\i c}"
  SPG_Dict_RTF("P4/mbm")="{\i P}4/{\i m}{\i b}{\i m}"
  SPG_Dict_RTF("P4/mnc")="{\i P}4/{\i m}{\i n}{\i c}"
  SPG_Dict_RTF("P4/nmm")="{\i P}4/{\i n}{\i m}{\i m}"
  SPG_Dict_RTF("P4/ncc")="{\i P}4/{\i n}{\i c}{\i c}"
  SPG_Dict_RTF("P42/mmc")="{\i P}4{\sub 2}/{\i m}{\i m}{\i c}"
  SPG_Dict_RTF("P42/mcm")="{\i P}4{\sub 2}/{\i m}{\i c}{\i m}"
  SPG_Dict_RTF("P42/nbc")="{\i P}4{\sub 2}/{\i n}{\i b}{\i c}"
  SPG_Dict_RTF("P42/nnm")="{\i P}4{\sub 2}/{\i n}{\i n}{\i m}"
  SPG_Dict_RTF("P42/mbc")="{\i P}4{\sub 2}/{\i m}{\i b}{\i c}"
  SPG_Dict_RTF("P42/mnm")="{\i P}4{\sub 2}/{\i m}{\i n}{\i m}"
  SPG_Dict_RTF("P42/nmc")="{\i P}4{\sub 2}/{\i n}{\i m}{\i c}"
  SPG_Dict_RTF("P42/ncm")="{\i P}4{\sub 2}/{\i n}{\i c}{\i m}"
  SPG_Dict_RTF("I4/mmm")="{\i I}4/{\i m}{\i m}{\i m}"
  SPG_Dict_RTF("I4/mcm")="{\i I}4/{\i m}{\i c}{\i m}"
  SPG_Dict_RTF("I41/amd")="{\i I}4{\sub 1}/{\i a}{\i m}{\i d}"
  SPG_Dict_RTF("I41/acd")="{\i I}4{\sub 1}/{\i a}{\i c}{\i d}"
  SPG_Dict_RTF("P3")="{\i P}3"
  SPG_Dict_RTF("P31")="{\i P}3{\sub 1}"
  SPG_Dict_RTF("P32")="{\i P}3{\sub 2}"
  SPG_Dict_RTF("R3")="{\i R}3"
  SPG_Dict_RTF("P-3")="{\i P}-3"
  SPG_Dict_RTF("R-3")="{\i R}-3"
  SPG_Dict_RTF("P312")="{\i P}312"
  SPG_Dict_RTF("P321")="{\i P}321"
  SPG_Dict_RTF("P3112")="{\i P}3{\sub 1}12"
  SPG_Dict_RTF("P3121")="{\i P}3{\sub 1}21"
  SPG_Dict_RTF("P3212")="{\i P}3{\sub 2}12"
  SPG_Dict_RTF("P3221")="{\i P}3{\sub 2}21"
  SPG_Dict_RTF("R32")="{\i R}32"
  SPG_Dict_RTF("P3m1")="{\i P}3{\i m}1"
  SPG_Dict_RTF("P31m")="{\i P}31{\i m}"
  SPG_Dict_RTF("P3c1")="{\i P}3{\i c}1"
  SPG_Dict_RTF("P31c")="{\i P}31{\i c}"
  SPG_Dict_RTF("R3m")="{\i R}3{\i m}"
  SPG_Dict_RTF("R3c")="{\i R}3{\i c}"
  SPG_Dict_RTF("P-31m")="{\i P}-31{\i m}"
  SPG_Dict_RTF("P-31c")="{\i P}-31{\i c}"
  SPG_Dict_RTF("P-3m1")="{\i P}-3{\i m}1"
  SPG_Dict_RTF("P-3c1")="{\i P}-3{\i c}1"
  SPG_Dict_RTF("R-3m")="{\i R}-3{\i m}"
  SPG_Dict_RTF("R-3c")="{\i R}-3{\i c}"
  SPG_Dict_RTF("P6")="{\i P}6"
  SPG_Dict_RTF("P61")="{\i P}6{\sub 1}"
  SPG_Dict_RTF("P65")="{\i P}6{\sub 5}"
  SPG_Dict_RTF("P62")="{\i P}6{\sub 2}"
  SPG_Dict_RTF("P64")="{\i P}6{\sub 4}"
  SPG_Dict_RTF("P63")="{\i P}6{\sub 3}"
  SPG_Dict_RTF("P-6")="{\i P}-6"
  SPG_Dict_RTF("P6/m")="{\i P}6/{\i m}"
  SPG_Dict_RTF("P63/m")="{\i P}6{\sub 3}/{\i m}"
  SPG_Dict_RTF("P622")="{\i P}622"
  SPG_Dict_RTF("P6122")="{\i P}6{\sub 1}22"
  SPG_Dict_RTF("P6522")="{\i P}6{\sub 5}22"
  SPG_Dict_RTF("P6222")="{\i P}6{\sub 2}22"
  SPG_Dict_RTF("P6422")="{\i P}6{\sub 4}22"
  SPG_Dict_RTF("P6322")="{\i P}6{\sub 3}22"
  SPG_Dict_RTF("P6mm")="{\i P}6{\i m}{\i m}"
  SPG_Dict_RTF("P6cc")="{\i P}6{\i c}{\i c}"
  SPG_Dict_RTF("P63cm")="{\i P}6{\sub 3}{\i c}{\i m}"
  SPG_Dict_RTF("P63mc")="{\i P}6{\sub 3}{\i m}{\i c}"
  SPG_Dict_RTF("P-6m2")="{\i P}-6{\i m}2"
  SPG_Dict_RTF("P-6c2")="{\i P}-6{\i c}2"
  SPG_Dict_RTF("P-62m")="{\i P}-62{\i m}"
  SPG_Dict_RTF("P-62c")="{\i P}-62{\i c}"
  SPG_Dict_RTF("P6/mmm")="{\i P}6/{\i m}{\i m}{\i m}"
  SPG_Dict_RTF("P6/mcc")="{\i P}6/{\i m}{\i c}{\i c}"
  SPG_Dict_RTF("P63/mcm")="{\i P}6{\sub 3}/{\i m}{\i c}{\i m}"
  SPG_Dict_RTF("P63/mmc")="{\i P}6{\sub 3}/{\i m}{\i m}{\i c}"
  SPG_Dict_RTF("P23")="{\i P}23"
  SPG_Dict_RTF("F23")="{\i F}23"
  SPG_Dict_RTF("I23")="{\i I}23"
  SPG_Dict_RTF("P213")="{\i P}2{\sub 1}3"
  SPG_Dict_RTF("I213")="{\i I}2{\sub 1}3"
  SPG_Dict_RTF("Pm-3")="{\i P}{\i m}-3"
  SPG_Dict_RTF("Pn-3")="{\i P}{\i n}-3"
  SPG_Dict_RTF("Fm-3")="{\i F}{\i m}-3"
  SPG_Dict_RTF("Fd-3")="{\i F}{\i d}-3"
  SPG_Dict_RTF("Im-3")="{\i I}{\i m}-3"
  SPG_Dict_RTF("Pa-3")="{\i P}{\i a}-3"
  SPG_Dict_RTF("Ia-3")="{\i I}{\i a}-3"
  SPG_Dict_RTF("P432")="{\i P}432"
  SPG_Dict_RTF("P4232")="{\i P}4{\sub 2}32"
  SPG_Dict_RTF("F432")="{\i F}432"
  SPG_Dict_RTF("F4132")="{\i F}4{\sub 1}32"
  SPG_Dict_RTF("I432")="{\i I}432"
  SPG_Dict_RTF("P4332")="{\i P}4{\sub 3}32"
  SPG_Dict_RTF("P4132")="{\i P}4{\sub 1}32"
  SPG_Dict_RTF("I4132")="{\i I}4{\sub 1}32"
  SPG_Dict_RTF("P-43m")="{\i P}-43{\i m}"
  SPG_Dict_RTF("F-43m")="{\i F}-43{\i m}"
  SPG_Dict_RTF("I-43m")="{\i I}-43{\i m}"
  SPG_Dict_RTF("P-43n")="{\i P}-43{\i n}"
  SPG_Dict_RTF("F-43c")="{\i F}-43{\i c}"
  SPG_Dict_RTF("I-43d")="{\i I}-43{\i d}"
  SPG_Dict_RTF("Pm-3m")="{\i P}{\i m}-3{\i m}"
  SPG_Dict_RTF("Pn-3n")="{\i P}{\i n}-3{\i n}"
  SPG_Dict_RTF("Pm-3n")="{\i P}{\i m}-3{\i n}"
  SPG_Dict_RTF("Pn-3m")="{\i P}{\i n}-3{\i m}"
  SPG_Dict_RTF("Fm-3m")="{\i F}{\i m}-3{\i m}"
  SPG_Dict_RTF("Fm-3c")="{\i F}{\i m}-3{\i c}"
  SPG_Dict_RTF("Fd-3m")="{\i F}{\i d}-3{\i m}"
  SPG_Dict_RTF("Fd-3c")="{\i F}{\i d}-3{\i c}"
  SPG_Dict_RTF("Im-3m")="{\i I}{\i m}-3{\i m}"
  SPG_Dict_RTF("Ia-3d")="{\i I}{\i a}-3{\i d}"
EndProcedure

Procedure Fill_SPG_Dict_Latex()
  SPG_Dict_Latex("P1")="P1"
  SPG_Dict_Latex("P-1")="P\bar{1}"
  SPG_Dict_Latex("P2")="P2"
  SPG_Dict_Latex("P21")="P2_1"
  SPG_Dict_Latex("C2")="C2"
  SPG_Dict_Latex("Pm")="Pm"
  SPG_Dict_Latex("Pc")="Pc"
  SPG_Dict_Latex("Cm")="Cm"
  SPG_Dict_Latex("Cc")="Cc"
  SPG_Dict_Latex("P2/m")="P2/m"
  SPG_Dict_Latex("P21/m")="P2_1/m"
  SPG_Dict_Latex("C2/m")="C2/m"
  SPG_Dict_Latex("P2/c")="P2/c"
  SPG_Dict_Latex("P21/c")="P2_1/c"
  SPG_Dict_Latex("P21/n")="P2_1/n"
  SPG_Dict_Latex("P21/a")="P2_1/a"
  SPG_Dict_Latex("C2/c")="C2/c"
  SPG_Dict_Latex("P222")="P222"
  SPG_Dict_Latex("P2221")="P222_1"
  SPG_Dict_Latex("P21212")="P2_12_12"
  SPG_Dict_Latex("P212121")="P2_12_12_1"
  SPG_Dict_Latex("C2221")="C222_1"
  SPG_Dict_Latex("C222")="C222"
  SPG_Dict_Latex("F222")="F222"
  SPG_Dict_Latex("I222")="I222"
  SPG_Dict_Latex("I212121")="I2_12_12_1"
  SPG_Dict_Latex("Pmm2")="Pmm2"
  SPG_Dict_Latex("Pmc21")="Pmc2_1"
  SPG_Dict_Latex("Pcc2")="Pcc2"
  SPG_Dict_Latex("Pma2")="Pma2"
  SPG_Dict_Latex("Pca21")="Pca2_1"
  SPG_Dict_Latex("Pnc2")="Pnc2"
  SPG_Dict_Latex("Pmn21")="Pmn2_1"
  SPG_Dict_Latex("Pba2")="Pba2"
  SPG_Dict_Latex("Pna21")="Pna2_1"
  SPG_Dict_Latex("Pnn2")="Pnn2"
  SPG_Dict_Latex("Cmm2")="Cmm2"
  SPG_Dict_Latex("Cmc21")="Cmc2_1"
  SPG_Dict_Latex("Ccc2")="Ccc2"
  SPG_Dict_Latex("Amm2")="Amm2"
  SPG_Dict_Latex("Abm2")="Abm2"
  SPG_Dict_Latex("Ama2")="Ama2"
  SPG_Dict_Latex("Aba2")="Aba2"
  SPG_Dict_Latex("Fmm2")="Fmm2"
  SPG_Dict_Latex("Fdd2")="Fdd2"
  SPG_Dict_Latex("Imm2")="Imm2"
  SPG_Dict_Latex("Iba2")="Iba2"
  SPG_Dict_Latex("Ima2")="Ima2"
  SPG_Dict_Latex("Pmmm")="Pmmm"
  SPG_Dict_Latex("Pnnn")="Pnnn"
  SPG_Dict_Latex("Pccm")="Pccm"
  SPG_Dict_Latex("Pban")="Pban"
  SPG_Dict_Latex("Pmma")="Pmma"
  SPG_Dict_Latex("Pnna")="Pnna"
  SPG_Dict_Latex("Pmna")="Pmna"
  SPG_Dict_Latex("Pcca")="Pcca"
  SPG_Dict_Latex("Pbam")="Pbam"
  SPG_Dict_Latex("Pccn")="Pccn"
  SPG_Dict_Latex("Pbcm")="Pbcm"
  SPG_Dict_Latex("Pnnm")="Pnnm"
  SPG_Dict_Latex("Pmmn")="Pmmn"
  SPG_Dict_Latex("Pbcn")="Pbcn"
  SPG_Dict_Latex("Pbca")="Pbca"
  SPG_Dict_Latex("Pnma")="Pnma"
  SPG_Dict_Latex("Cmcm")="Cmcm"
  SPG_Dict_Latex("Cmca")="Cmca"
  SPG_Dict_Latex("Cmmm")="Cmmm"
  SPG_Dict_Latex("Cccm")="Cccm"
  SPG_Dict_Latex("Cmma")="Cmma"
  SPG_Dict_Latex("Ccca")="Ccca"
  SPG_Dict_Latex("Fmmm")="Fmmm"
  SPG_Dict_Latex("Fddd")="Fddd"
  SPG_Dict_Latex("Immm")="Immm"
  SPG_Dict_Latex("Ibam")="Ibam"
  SPG_Dict_Latex("Ibca")="Ibca"
  SPG_Dict_Latex("Imma")="Imma"
  SPG_Dict_Latex("P4")="P4"
  SPG_Dict_Latex("P41")="P4_1"
  SPG_Dict_Latex("P42")="P4_2"
  SPG_Dict_Latex("P43")="P4_3"
  SPG_Dict_Latex("I4")="I4"
  SPG_Dict_Latex("I41")="I4_1"
  SPG_Dict_Latex("P-4")="P\bar{4}"
  SPG_Dict_Latex("I-4")="I\bar{4}"
  SPG_Dict_Latex("P4/m")="P4/m"
  SPG_Dict_Latex("P42/m")="P4_2/m"
  SPG_Dict_Latex("P4/n")="P4/n"
  SPG_Dict_Latex("P42/n")="P4_2/n"
  SPG_Dict_Latex("I4/m")="I4/m"
  SPG_Dict_Latex("I41/a")="I4_1/a"
  SPG_Dict_Latex("P422")="P422"
  SPG_Dict_Latex("P4212")="P42_12"
  SPG_Dict_Latex("P4122")="P4_122"
  SPG_Dict_Latex("P41212")="P4_12_12"
  SPG_Dict_Latex("P4222")="P4_222"
  SPG_Dict_Latex("P42212")="P4_22_12"
  SPG_Dict_Latex("P4322")="P4_322"
  SPG_Dict_Latex("P43212")="P4_32_12"
  SPG_Dict_Latex("I422")="I422"
  SPG_Dict_Latex("I4122")="I4_122"
  SPG_Dict_Latex("P4mm")="P4mm"
  SPG_Dict_Latex("P4bm")="P4bm"
  SPG_Dict_Latex("P42cm")="P4_2cm"
  SPG_Dict_Latex("P42nm")="P4_2nm"
  SPG_Dict_Latex("P4cc")="P4cc"
  SPG_Dict_Latex("P4nc")="P4nc"
  SPG_Dict_Latex("P42mc")="P4_2mc"
  SPG_Dict_Latex("P42bc")="P4_2bc"
  SPG_Dict_Latex("I4mm")="I4mm"
  SPG_Dict_Latex("I4cm")="I4cm"
  SPG_Dict_Latex("I41md")="I4_1md"
  SPG_Dict_Latex("I41cd")="I4_1cd"
  SPG_Dict_Latex("P-42m")="P\bar{4}2m"
  SPG_Dict_Latex("P-42c")="P\bar{4}2c"
  SPG_Dict_Latex("P-421m")="P\bar{4}2_1m"
  SPG_Dict_Latex("P-421c")="P\bar{4}2_1c"
  SPG_Dict_Latex("P-4m2")="P\bar{4}m2"
  SPG_Dict_Latex("P-4c2")="P\bar{4}c2"
  SPG_Dict_Latex("P-4b2")="P\bar{4}b2"
  SPG_Dict_Latex("P-4n2")="P\bar{4}n2"
  SPG_Dict_Latex("I-4m2")="I\bar{4}m2"
  SPG_Dict_Latex("I-4c2")="I\bar{4}c2"
  SPG_Dict_Latex("I-42m")="I\bar{4}2m"
  SPG_Dict_Latex("I-42d")="I\bar{4}2d"
  SPG_Dict_Latex("P4/mmm")="P4/mmm"
  SPG_Dict_Latex("P4/mcc")="P4/mcc"
  SPG_Dict_Latex("P4/nbm")="P4/nbm"
  SPG_Dict_Latex("P4/nnc")="P4/nnc"
  SPG_Dict_Latex("P4/mbm")="P4/mbm"
  SPG_Dict_Latex("P4/mnc")="P4/mnc"
  SPG_Dict_Latex("P4/nmm")="P4/nmm"
  SPG_Dict_Latex("P4/ncc")="P4/ncc"
  SPG_Dict_Latex("P42/mmc")="P4_2/mmc"
  SPG_Dict_Latex("P42/mcm")="P4_2/mcm"
  SPG_Dict_Latex("P42/nbc")="P4_2/nbc"
  SPG_Dict_Latex("P42/nnm")="P4_2/nnm"
  SPG_Dict_Latex("P42/mbc")="P4_2/mbc"
  SPG_Dict_Latex("P42/mnm")="P4_2/mnm"
  SPG_Dict_Latex("P42/nmc")="P4_2/nmc"
  SPG_Dict_Latex("P42/ncm")="P4_2/ncm"
  SPG_Dict_Latex("I4/mmm")="I4/mmm"
  SPG_Dict_Latex("I4/mcm")="I4/mcm"
  SPG_Dict_Latex("I41/amd")="I4_1/amd"
  SPG_Dict_Latex("I41/acd")="I4_1/acd"
  SPG_Dict_Latex("P3")="P3"
  SPG_Dict_Latex("P31")="P3_1"
  SPG_Dict_Latex("P32")="P3_2"
  SPG_Dict_Latex("R3")="R3"
  SPG_Dict_Latex("P-3")="P\bar{3}"
  SPG_Dict_Latex("R-3")="R\bar{3}"
  SPG_Dict_Latex("P312")="P312"
  SPG_Dict_Latex("P321")="P321"
  SPG_Dict_Latex("P3112")="P3_112"
  SPG_Dict_Latex("P3121")="P3_121"
  SPG_Dict_Latex("P3212")="P3_212"
  SPG_Dict_Latex("P3221")="P3_221"
  SPG_Dict_Latex("R32")="R32"
  SPG_Dict_Latex("P3m1")="P3m1"
  SPG_Dict_Latex("P31m")="P31m"
  SPG_Dict_Latex("P3c1")="P3c1"
  SPG_Dict_Latex("P31c")="P31c"
  SPG_Dict_Latex("R3m")="R3m"
  SPG_Dict_Latex("R3c")="R3c"
  SPG_Dict_Latex("P-31m")="P\bar{3}1m"
  SPG_Dict_Latex("P-31c")="P\bar{3}1c"
  SPG_Dict_Latex("P-3m1")="P\bar{3}m1"
  SPG_Dict_Latex("P-3c1")="P\bar{3}c1"
  SPG_Dict_Latex("R-3m")="R\bar{3}m"
  SPG_Dict_Latex("R-3c")="R\bar{3}c"
  SPG_Dict_Latex("P6")="P6"
  SPG_Dict_Latex("P61")="P6_1"
  SPG_Dict_Latex("P65")="P6_5"
  SPG_Dict_Latex("P62")="P6_2"
  SPG_Dict_Latex("P64")="P6_4"
  SPG_Dict_Latex("P63")="P6_3"
  SPG_Dict_Latex("P-6")="P\bar{6}"
  SPG_Dict_Latex("P6/m")="P6/m"
  SPG_Dict_Latex("P63/m")="P6_3/m"
  SPG_Dict_Latex("P622")="P622"
  SPG_Dict_Latex("P6122")="P6_122"
  SPG_Dict_Latex("P6522")="P6_522"
  SPG_Dict_Latex("P6222")="P6_222"
  SPG_Dict_Latex("P6422")="P6_422"
  SPG_Dict_Latex("P6322")="P6_322"
  SPG_Dict_Latex("P6mm")="P6mm"
  SPG_Dict_Latex("P6cc")="P6cc"
  SPG_Dict_Latex("P63cm")="P6_3cm"
  SPG_Dict_Latex("P63mc")="P6_3mc"
  SPG_Dict_Latex("P-6m2")="P\bar{6}m2"
  SPG_Dict_Latex("P-6c2")="P\bar{6}c2"
  SPG_Dict_Latex("P-62m")="P\bar{6}2m"
  SPG_Dict_Latex("P-62c")="P\bar{6}2c"
  SPG_Dict_Latex("P6/mmm")="P6/mmm"
  SPG_Dict_Latex("P6/mcc")="P6/mcc"
  SPG_Dict_Latex("P63/mcm")="P6_3/mcm"
  SPG_Dict_Latex("P63/mmc")="P6_3/mmc"
  SPG_Dict_Latex("P23")="P23"
  SPG_Dict_Latex("F23")="F23"
  SPG_Dict_Latex("I23")="I23"
  SPG_Dict_Latex("P213")="P2_13"
  SPG_Dict_Latex("I213")="I2_13"
  SPG_Dict_Latex("Pm-3")="Pm\bar{3}"
  SPG_Dict_Latex("Pn-3")="Pn\bar{3}"
  SPG_Dict_Latex("Fm-3")="Fm\bar{3}"
  SPG_Dict_Latex("Fd-3")="Fd\bar{3}"
  SPG_Dict_Latex("Im-3")="Im\bar{3}"
  SPG_Dict_Latex("Pa-3")="Pa\bar{3}"
  SPG_Dict_Latex("Ia-3")="Ia\bar{3}"
  SPG_Dict_Latex("P432")="P432"
  SPG_Dict_Latex("P4232")="P4_232"
  SPG_Dict_Latex("F432")="F432"
  SPG_Dict_Latex("F4132")="F4_132"
  SPG_Dict_Latex("I432")="I432"
  SPG_Dict_Latex("P4332")="P4_332"
  SPG_Dict_Latex("P4132")="P4_132"
  SPG_Dict_Latex("I4132")="I4_132"
  SPG_Dict_Latex("P-43m")="P\bar{4}3m"
  SPG_Dict_Latex("F-43m")="F\bar{4}3m"
  SPG_Dict_Latex("I-43m")="I\bar{4}3m"
  SPG_Dict_Latex("P-43n")="P\bar{4}3n"
  SPG_Dict_Latex("F-43c")="F\bar{4}3c"
  SPG_Dict_Latex("I-43d")="I\bar{4}3d"
  SPG_Dict_Latex("Pm-3m")="Pm\bar{3}m"
  SPG_Dict_Latex("Pn-3n")="Pn\bar{3}n"
  SPG_Dict_Latex("Pm-3n")="Pm\bar{3}n"
  SPG_Dict_Latex("Pn-3m")="Pn\bar{3}m"
  SPG_Dict_Latex("Fm-3m")="Fm\bar{3}m"
  SPG_Dict_Latex("Fm-3c")="Fm\bar{3}c"
  SPG_Dict_Latex("Fd-3m")="Fd\bar{3}m"
  SPG_Dict_Latex("Fd-3c")="Fd\bar{3}c"
  SPG_Dict_Latex("Im-3m")="Im\bar{3}m"
  SPG_Dict_Latex("Ia-3d")="Ia\bar{3}d"
EndProcedure

Procedure Fill_SPG_Dict_Markdown_Ascii()
  SPG_Dict_Markdown_Ascii("P1")="*P*1"
  SPG_Dict_Markdown_Ascii("P-1")="*P*-1"
  SPG_Dict_Markdown_Ascii("P2")="*P*2"
  SPG_Dict_Markdown_Ascii("P21")="*P*2~1~"
  SPG_Dict_Markdown_Ascii("C2")="*C*2"
  SPG_Dict_Markdown_Ascii("Pm")="*Pm*"
  SPG_Dict_Markdown_Ascii("Pc")="*Pc*"
  SPG_Dict_Markdown_Ascii("Cm")="*Cm*"
  SPG_Dict_Markdown_Ascii("Cc")="*Cc*"
  SPG_Dict_Markdown_Ascii("P2/m")="*P*2/*m*"
  SPG_Dict_Markdown_Ascii("P21/m")="*P*2~1~/*m*"
  SPG_Dict_Markdown_Ascii("C2/m")="*C*2/*m*"
  SPG_Dict_Markdown_Ascii("P2/c")="*P*2/*c*"
  SPG_Dict_Markdown_Ascii("P21/c")="*P*2~1~/*c*"
  SPG_Dict_Markdown_Ascii("P21/n")="*P*2~1~/*n*"
  SPG_Dict_Markdown_Ascii("P21/a")="*P*2~1~/*a*"
  SPG_Dict_Markdown_Ascii("C2/c")="*C*2/*c*"
  SPG_Dict_Markdown_Ascii("P222")="*P*222"
  SPG_Dict_Markdown_Ascii("P2221")="*P*222~1~"
  SPG_Dict_Markdown_Ascii("P21212")="*P*2~1~2~1~2"
  SPG_Dict_Markdown_Ascii("P212121")="*P*2~1~2~1~2~1~"
  SPG_Dict_Markdown_Ascii("C2221")="*C*222~1~"
  SPG_Dict_Markdown_Ascii("C222")="*C*222"
  SPG_Dict_Markdown_Ascii("F222")="*F*222"
  SPG_Dict_Markdown_Ascii("I222")="*I*222"
  SPG_Dict_Markdown_Ascii("I212121")="*I*2~1~2~1~2~1~"
  SPG_Dict_Markdown_Ascii("Pmm2")="*Pmm*2"
  SPG_Dict_Markdown_Ascii("Pmc21")="*Pmc*2~1~"
  SPG_Dict_Markdown_Ascii("Pcc2")="*Pcc*2"
  SPG_Dict_Markdown_Ascii("Pma2")="*Pma*2"
  SPG_Dict_Markdown_Ascii("Pca21")="*Pca*2~1~"
  SPG_Dict_Markdown_Ascii("Pnc2")="*Pnc*2"
  SPG_Dict_Markdown_Ascii("Pmn21")="*Pmn*2~1~"
  SPG_Dict_Markdown_Ascii("Pba2")="*Pba*2"
  SPG_Dict_Markdown_Ascii("Pna21")="*Pna*2~1~"
  SPG_Dict_Markdown_Ascii("Pnn2")="*Pnn*2"
  SPG_Dict_Markdown_Ascii("Cmm2")="*Cmm*2"
  SPG_Dict_Markdown_Ascii("Cmc21")="*Cmc*2~1~"
  SPG_Dict_Markdown_Ascii("Ccc2")="*Ccc*2"
  SPG_Dict_Markdown_Ascii("Amm2")="*Amm*2"
  SPG_Dict_Markdown_Ascii("Abm2")="*Abm*2"
  SPG_Dict_Markdown_Ascii("Ama2")="*Ama*2"
  SPG_Dict_Markdown_Ascii("Aba2")="*Aba*2"
  SPG_Dict_Markdown_Ascii("Fmm2")="*Fmm*2"
  SPG_Dict_Markdown_Ascii("Fdd2")="*Fdd*2"
  SPG_Dict_Markdown_Ascii("Imm2")="*Imm*2"
  SPG_Dict_Markdown_Ascii("Iba2")="*Iba*2"
  SPG_Dict_Markdown_Ascii("Ima2")="*Ima*2"
  SPG_Dict_Markdown_Ascii("Pmmm")="*Pmmm*"
  SPG_Dict_Markdown_Ascii("Pnnn")="*Pnnn*"
  SPG_Dict_Markdown_Ascii("Pccm")="*Pccm*"
  SPG_Dict_Markdown_Ascii("Pban")="*Pban*"
  SPG_Dict_Markdown_Ascii("Pmma")="*Pmma*"
  SPG_Dict_Markdown_Ascii("Pnna")="*Pnna*"
  SPG_Dict_Markdown_Ascii("Pmna")="*Pmna*"
  SPG_Dict_Markdown_Ascii("Pcca")="*Pcca*"
  SPG_Dict_Markdown_Ascii("Pbam")="*Pbam*"
  SPG_Dict_Markdown_Ascii("Pccn")="*Pccn*"
  SPG_Dict_Markdown_Ascii("Pbcm")="*Pbcm*"
  SPG_Dict_Markdown_Ascii("Pnnm")="*Pnnm*"
  SPG_Dict_Markdown_Ascii("Pmmn")="*Pmmn*"
  SPG_Dict_Markdown_Ascii("Pbcn")="*Pbcn*"
  SPG_Dict_Markdown_Ascii("Pbca")="*Pbca*"
  SPG_Dict_Markdown_Ascii("Pnma")="*Pnma*"
  SPG_Dict_Markdown_Ascii("Cmcm")="*Cmcm*"
  SPG_Dict_Markdown_Ascii("Cmca")="*Cmca*"
  SPG_Dict_Markdown_Ascii("Cmmm")="*Cmmm*"
  SPG_Dict_Markdown_Ascii("Cccm")="*Cccm*"
  SPG_Dict_Markdown_Ascii("Cmma")="*Cmma*"
  SPG_Dict_Markdown_Ascii("Ccca")="*Ccca*"
  SPG_Dict_Markdown_Ascii("Fmmm")="*Fmmm*"
  SPG_Dict_Markdown_Ascii("Fddd")="*Fddd*"
  SPG_Dict_Markdown_Ascii("Immm")="*Immm*"
  SPG_Dict_Markdown_Ascii("Ibam")="*Ibam*"
  SPG_Dict_Markdown_Ascii("Ibca")="*Ibca*"
  SPG_Dict_Markdown_Ascii("Imma")="*Imma*"
  SPG_Dict_Markdown_Ascii("P4")="*P*4"
  SPG_Dict_Markdown_Ascii("P41")="*P*4~1~"
  SPG_Dict_Markdown_Ascii("P42")="*P*4~2~"
  SPG_Dict_Markdown_Ascii("P43")="*P*4~3~"
  SPG_Dict_Markdown_Ascii("I4")="*I*4"
  SPG_Dict_Markdown_Ascii("I41")="*I*4~1~"
  SPG_Dict_Markdown_Ascii("P-4")="*P*-4"
  SPG_Dict_Markdown_Ascii("I-4")="*I*-4"
  SPG_Dict_Markdown_Ascii("P4/m")="*P*4/*m*"
  SPG_Dict_Markdown_Ascii("P42/m")="*P*4~2~/*m*"
  SPG_Dict_Markdown_Ascii("P4/n")="*P*4/*n*"
  SPG_Dict_Markdown_Ascii("P42/n")="*P*4~2~/*n*"
  SPG_Dict_Markdown_Ascii("I4/m")="*I*4/*m*"
  SPG_Dict_Markdown_Ascii("I41/a")="*I*4~1~/*a*"
  SPG_Dict_Markdown_Ascii("P422")="*P*422"
  SPG_Dict_Markdown_Ascii("P4212")="*P*42~1~2"
  SPG_Dict_Markdown_Ascii("P4122")="*P*4~1~22"
  SPG_Dict_Markdown_Ascii("P41212")="*P*4~1~2~1~2"
  SPG_Dict_Markdown_Ascii("P4222")="*P*4~2~22"
  SPG_Dict_Markdown_Ascii("P42212")="*P*4~2~2~2~2"
  SPG_Dict_Markdown_Ascii("P4322")="*P*4~3~22"
  SPG_Dict_Markdown_Ascii("P43212")="*P*4~3~2~1~2"
  SPG_Dict_Markdown_Ascii("I422")="*I*422"
  SPG_Dict_Markdown_Ascii("I4122")="*I*4~1~22"
  SPG_Dict_Markdown_Ascii("P4mm")="*P*4*mm*"
  SPG_Dict_Markdown_Ascii("P4bm")="*P*4*bm*"
  SPG_Dict_Markdown_Ascii("P42cm")="*P*4~2~*cm*"
  SPG_Dict_Markdown_Ascii("P42nm")="*P*4~2~*nm*"
  SPG_Dict_Markdown_Ascii("P4cc")="*P*4*cc*"
  SPG_Dict_Markdown_Ascii("P4nc")="*P*4*nc*"
  SPG_Dict_Markdown_Ascii("P42mc")="*P*4~2~*mc*"
  SPG_Dict_Markdown_Ascii("P42bc")="*P*4~2~*bc*"
  SPG_Dict_Markdown_Ascii("I4mm")="*I*4*mm*"
  SPG_Dict_Markdown_Ascii("I4cm")="*I*4*cm*"
  SPG_Dict_Markdown_Ascii("I41md")="*I*4~1~*md*"
  SPG_Dict_Markdown_Ascii("I41cd")="*I*4~1~*cd*"
  SPG_Dict_Markdown_Ascii("P-42m")="*P*-42*m*"
  SPG_Dict_Markdown_Ascii("P-42c")="*P*-42*c*"
  SPG_Dict_Markdown_Ascii("P-421m")="*P*-42~1~*m*"
  SPG_Dict_Markdown_Ascii("P-421c")="*P*-42~1~*c*"
  SPG_Dict_Markdown_Ascii("P-4m2")="*P*-4*m*2"
  SPG_Dict_Markdown_Ascii("P-4c2")="*P*-4*c*2"
  SPG_Dict_Markdown_Ascii("P-4b2")="*P*-4*b*2"
  SPG_Dict_Markdown_Ascii("P-4n2")="*P*-4*n*2"
  SPG_Dict_Markdown_Ascii("I-4m2")="*I*-4*m*2"
  SPG_Dict_Markdown_Ascii("I-4c2")="*I*-4*c*2"
  SPG_Dict_Markdown_Ascii("I-42m")="*I*-42*m*"
  SPG_Dict_Markdown_Ascii("I-42d")="*I*-42*d*"
  SPG_Dict_Markdown_Ascii("P4/mmm")="*P*4/*mmm*"
  SPG_Dict_Markdown_Ascii("P4/mcc")="*P*4/*mcc*"
  SPG_Dict_Markdown_Ascii("P4/nbm")="*P*4/*nbm*"
  SPG_Dict_Markdown_Ascii("P4/nnc")="*P*4/*nnc*"
  SPG_Dict_Markdown_Ascii("P4/mbm")="*P*4/*mbm*"
  SPG_Dict_Markdown_Ascii("P4/mnc")="*P*4/*mnc*"
  SPG_Dict_Markdown_Ascii("P4/nmm")="*P*4/*nmm*"
  SPG_Dict_Markdown_Ascii("P4/ncc")="*P*4/*ncc*"
  SPG_Dict_Markdown_Ascii("P42/mmc")="*P*4~2~/*mmc*"
  SPG_Dict_Markdown_Ascii("P42/mcm")="*P*4~2~/*mcm*"
  SPG_Dict_Markdown_Ascii("P42/nbc")="*P*4~2~/*nbc*"
  SPG_Dict_Markdown_Ascii("P42/nnm")="*P*4~2~/*nnm*"
  SPG_Dict_Markdown_Ascii("P42/mbc")="*P*4~2~/*mbc*"
  SPG_Dict_Markdown_Ascii("P42/mnm")="*P*4~2~/*mnm*"
  SPG_Dict_Markdown_Ascii("P42/nmc")="*P*4~2~/*nmc*"
  SPG_Dict_Markdown_Ascii("P42/ncm")="*P*4~2~/*ncm*"
  SPG_Dict_Markdown_Ascii("I4/mmm")="*I*4/*mmm*"
  SPG_Dict_Markdown_Ascii("I4/mcm")="*I*4/*mcm*"
  SPG_Dict_Markdown_Ascii("I41/amd")="*I*4~1~/*amd*"
  SPG_Dict_Markdown_Ascii("I41/acd")="*I*4~1~/*acd*"
  SPG_Dict_Markdown_Ascii("P3")="*P*3"
  SPG_Dict_Markdown_Ascii("P31")="*P*3~1~"
  SPG_Dict_Markdown_Ascii("P32")="*P*3~2~"
  SPG_Dict_Markdown_Ascii("R3")="*R*3"
  SPG_Dict_Markdown_Ascii("P-3")="*P*-3"
  SPG_Dict_Markdown_Ascii("R-3")="*R*-3"
  SPG_Dict_Markdown_Ascii("P312")="*P*312"
  SPG_Dict_Markdown_Ascii("P321")="*P*321"
  SPG_Dict_Markdown_Ascii("P3112")="*P*3~1~12"
  SPG_Dict_Markdown_Ascii("P3121")="*P*3~1~21"
  SPG_Dict_Markdown_Ascii("P3212")="*P*3~2~12"
  SPG_Dict_Markdown_Ascii("P3221")="*P*3~2~21"
  SPG_Dict_Markdown_Ascii("R32")="*R*32"
  SPG_Dict_Markdown_Ascii("P3m1")="*P*3*m*1"
  SPG_Dict_Markdown_Ascii("P31m")="*P*31*m*"
  SPG_Dict_Markdown_Ascii("P3c1")="*P*3*c*1"
  SPG_Dict_Markdown_Ascii("P31c")="*P*31*c*"
  SPG_Dict_Markdown_Ascii("R3m")="*R*3*m*"
  SPG_Dict_Markdown_Ascii("R3c")="*R*3*c*"
  SPG_Dict_Markdown_Ascii("P-31m")="*P*-31*m*"
  SPG_Dict_Markdown_Ascii("P-31c")="*P*-31*c*"
  SPG_Dict_Markdown_Ascii("P-3m1")="*P*-3*m*1"
  SPG_Dict_Markdown_Ascii("P-3c1")="*P*-3*c*1"
  SPG_Dict_Markdown_Ascii("R-3m")="*R*-3*m*"
  SPG_Dict_Markdown_Ascii("R-3c")="*R*-3*c*"
  SPG_Dict_Markdown_Ascii("P6")="*P*6"
  SPG_Dict_Markdown_Ascii("P61")="*P*6~1~"
  SPG_Dict_Markdown_Ascii("P65")="*P*6~5~"
  SPG_Dict_Markdown_Ascii("P62")="*P*6~2~"
  SPG_Dict_Markdown_Ascii("P64")="*P*6~4~"
  SPG_Dict_Markdown_Ascii("P63")="*P*6~3~"
  SPG_Dict_Markdown_Ascii("P-6")="*P*-6"
  SPG_Dict_Markdown_Ascii("P6/m")="*P*6/*m*"
  SPG_Dict_Markdown_Ascii("P63/m")="*P*6~3~/*m*"
  SPG_Dict_Markdown_Ascii("P622")="*P*622"
  SPG_Dict_Markdown_Ascii("P6122")="*P*6~1~22"
  SPG_Dict_Markdown_Ascii("P6522")="*P*6~5~22"
  SPG_Dict_Markdown_Ascii("P6222")="*P*6~2~22"
  SPG_Dict_Markdown_Ascii("P6422")="*P*6~4~22"
  SPG_Dict_Markdown_Ascii("P6322")="*P*6~3~22"
  SPG_Dict_Markdown_Ascii("P6mm")="*P*6*mm*"
  SPG_Dict_Markdown_Ascii("P6cc")="*P*6*cc*"
  SPG_Dict_Markdown_Ascii("P63cm")="*P*6~3~*cm*"
  SPG_Dict_Markdown_Ascii("P63mc")="*P*6~3~*mc*"
  SPG_Dict_Markdown_Ascii("P-6m2")="*P*-6*m*2"
  SPG_Dict_Markdown_Ascii("P-6c2")="*P*-6*c*2"
  SPG_Dict_Markdown_Ascii("P-62m")="*P*-62*m*"
  SPG_Dict_Markdown_Ascii("P-62c")="*P*-62*c*"
  SPG_Dict_Markdown_Ascii("P6/mmm")="*P*6/*mmm*"
  SPG_Dict_Markdown_Ascii("P6/mcc")="*P*6/*mcc*"
  SPG_Dict_Markdown_Ascii("P63/mcm")="*P*6~3~/*mcm*"
  SPG_Dict_Markdown_Ascii("P63/mmc")="*P*6~3~/*mmc*"
  SPG_Dict_Markdown_Ascii("P23")="*P*23"
  SPG_Dict_Markdown_Ascii("F23")="*F*23"
  SPG_Dict_Markdown_Ascii("I23")="*I*23"
  SPG_Dict_Markdown_Ascii("P213")="*P*2~1~3"
  SPG_Dict_Markdown_Ascii("I213")="*I*2~1~3"
  SPG_Dict_Markdown_Ascii("Pm-3")="*Pm*-3"
  SPG_Dict_Markdown_Ascii("Pn-3")="*Pn*-3"
  SPG_Dict_Markdown_Ascii("Fm-3")="*Fm*-3"
  SPG_Dict_Markdown_Ascii("Fd-3")="*Fd*-3"
  SPG_Dict_Markdown_Ascii("Im-3")="*Im*-3"
  SPG_Dict_Markdown_Ascii("Pa-3")="*Pa*-3"
  SPG_Dict_Markdown_Ascii("Ia-3")="*Ia*-3"
  SPG_Dict_Markdown_Ascii("P432")="*P*432"
  SPG_Dict_Markdown_Ascii("P4232")="*P*4~2~32"
  SPG_Dict_Markdown_Ascii("F432")="*F*432"
  SPG_Dict_Markdown_Ascii("F4132")="*F*4~1~32"
  SPG_Dict_Markdown_Ascii("I432")="*I*432"
  SPG_Dict_Markdown_Ascii("P4332")="*P*4~3~32"
  SPG_Dict_Markdown_Ascii("P4132")="*P*4~1~32"
  SPG_Dict_Markdown_Ascii("I4132")="*I*4~1~32"
  SPG_Dict_Markdown_Ascii("P-43m")="*P*-43*m*"
  SPG_Dict_Markdown_Ascii("F-43m")="*F*-43*m*"
  SPG_Dict_Markdown_Ascii("I-43m")="*I*-43*m*"
  SPG_Dict_Markdown_Ascii("P-43n")="*P*-43*n*"
  SPG_Dict_Markdown_Ascii("F-43c")="*F*-43*c*"
  SPG_Dict_Markdown_Ascii("I-43d")="*I*-43*d*"
  SPG_Dict_Markdown_Ascii("Pm-3m")="*Pm*-3*m*"
  SPG_Dict_Markdown_Ascii("Pn-3n")="*Pn*-3*n*"
  SPG_Dict_Markdown_Ascii("Pm-3n")="*Pm*-3*n*"
  SPG_Dict_Markdown_Ascii("Pn-3m")="*Pn*-3*m*"
  SPG_Dict_Markdown_Ascii("Fm-3m")="*Fm*-3*m*"
  SPG_Dict_Markdown_Ascii("Fm-3c")="*Fm*-3*c*"
  SPG_Dict_Markdown_Ascii("Fd-3m")="*Fd*-3*m*"
  SPG_Dict_Markdown_Ascii("Fd-3c")="*Fd*-3*c*"
  SPG_Dict_Markdown_Ascii("Im-3m")="*Im*-3*m*"
  SPG_Dict_Markdown_Ascii("Ia-3d")="*Ia*-3*d*"
EndProcedure

DataSection
  Help_Text:
  IncludeBinary "help.txt"
  Data.b 0 
EndDataSection

DataSection
  License_Text:
  IncludeBinary "license.txt"
  Data.b 0 
EndDataSection
