unit ucDOC;

interface

implementation

{
var
  MyTreeNode1, MyTreeNode2: TTreeNode;
begin
  with TreeView1.Items do
  begin
    MyTreeNode1 := Add(nil, 'RootTreeNode1');
    AddChild(MyTreeNode1,'ChildNode1');

    MyTreeNode2 := Add(MyTreeNode1, 'RootTreeNode2');
    AddChild(MyTreeNode2,'ChildNode2');

    MyTreeNode2 := TreeView1.Items[3];
    AddChild(MyTreeNode2,'ChildNode2a');

    Add(MyTreeNode2,'ChildNode2b');

    Add(MyTreeNode1, 'RootTreeNode3');
  end;

end;
}

{
const
  cselect  = 'select <DS_CAMPO> from <DS_TABELA> <DS_WHERE> <DS_GROUP> <DS_ORDER>';
  cInsert  = 'insert into <DS_TABELA> (<DS_CAMPO>) values (<DS_VALUE>)';
  cDelete  = 'delete from <DS_TABELA> <DS_WHERE>';
  cUpdate  = 'update <DS_TABELA> set <DS_CAMPO> <DS_WHERE>';
  cwhere   = 'where <DS_WHERE>';
  cGroupBy = 'group by <DS_GROUP>';
  cOrderBy = 'order by <DS_ORDER>';
}

{
  //--------------------------------------------------- SELECT

  vAux := cselect;
  vAux := AnsiReplaceStr(vAux,'<DS_CAMPO>','*');
  vAux := AnsiReplaceStr(vAux,'<DS_TABELA>',eTABELA.Text);
  if (eWHERE.Text <> '') then
  begin
    vAux := AnsiReplaceStr(vAux,'<DS_WHERE>',cwhere);
    vAux := AnsiReplaceStr(vAux,'<DS_WHERE>',eWHERE.Text);
  end
  else
  begin
    vAux := AnsiReplaceStr(vAux,'<DS_WHERE>','');
  end;
  if (eGROUP.Text <> '') then
  begin
    vAux := AnsiReplaceStr(vAux,'<DS_GROUP>',cGroupBy);
    vAux := AnsiReplaceStr(vAux,'<DS_GROUP>',eGROUP.Text);
  end
  else
  begin
    vAux := AnsiReplaceStr(vAux,'<DS_GROUP>','');
  end;
  if (eORDER.Text <> '') then
  begin
    vAux := AnsiReplaceStr(vAux,'<DS_ORDER>',cOrderBy);
    vAux := AnsiReplaceStr(vAux,'<DS_ORDER>',eORDER.Text);
  end
  else
  begin
    vAux := AnsiReplaceStr(vAux,'<DS_ORDER>','');
  end;
  mmSELECT.Lines.Clear;
  mmSELECT.Lines.Add( vAux );

  //--------------------------------------------------- INSERT

  vAux := cInsert;
  vAux := AnsiReplaceStr(vAux,'(<DS_CAMPO>)','');
  vAux := AnsiReplaceStr(vAux,'<DS_TABELA>',eTABELA.Text);
  vAux := AnsiReplaceStr(vAux,'<DS_VALUE>',' * ');
  mmINSERT.Lines.Clear;
  mmINSERT.Lines.Add( vAux );

  //--------------------------------------------------- UPDATE

  vAux := cUpdate;
  vAux := AnsiReplaceStr(vAux,'<DS_CAMPO>',' * ');
  vAux := AnsiReplaceStr(vAux,'<DS_TABELA>',eTABELA.Text);
  if (eWHERE.Text <> '') then
  begin
    vAux := AnsiReplaceStr(vAux,'<DS_WHERE>',cwhere);
    vAux := AnsiReplaceStr(vAux,'<DS_WHERE>',eWHERE.Text);
  end
  else
  begin
    vAux := AnsiReplaceStr(vAux,'<DS_WHERE>','');
  end;
  mmUPDATE.Lines.Clear;
  mmUPDATE.Lines.Add( vAux );

  //--------------------------------------------------- DELETE

  vAux := cDelete;
  vAux := AnsiReplaceStr(vAux,'<DS_TABELA>',eTABELA.Text);
  if (eWHERE.Text <> '') then
  begin
    vAux := AnsiReplaceStr(vAux,'<DS_WHERE>',cwhere);
    vAux := AnsiReplaceStr(vAux,'<DS_WHERE>',eWHERE.Text);
  end
  else
  begin
    vAux := AnsiReplaceStr(vAux,'<DS_WHERE>','');
  end;
  mmDELETE.Lines.Clear;
  mmDELETE.Lines.Add( vAux );

  }

  {

  FALTA
    CONTROLE DE ACESSO...
      LOGIN...
      CADASTRO USUARIO...
        NIVEL...
    LOG DE ALTERACAO...
    BACKUP...
    IMPRESSAO DO CARTAO...

  }

  {
  Obter campos
    Chave
    Corpo
    Todos
  Criar comando SQL
    select CAMPOS from TABELA where CLAUSULA;
    insert int TABELA (CAMPOS) values (VALORES);
    update TABELA set CAMPOS where CLAUSULA;
    delete from TABELA where CLAUSULA;
  }

//var  
//  v_Param : TStringList;
//begin
//  v_Param:=TStringList.Create;
//  v_Param.LoadFromFile(ExtractFilePath(Application.ExeName)+'Dados.cfg');
//  SQLConnection1.Params.Values['Database'] := v_Param.Strings[0];
//  v_Param.Free;
//end;

end.
