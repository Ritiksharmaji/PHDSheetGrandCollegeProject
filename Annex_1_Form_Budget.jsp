<%@ include file="javabean.jsp" %>
<%@ page import="java.sql.*" %>

<%
int budget = 200000;  // get from db;
String appn = (String) session.getAttribute("appno");
int tenure = (Integer) session.getAttribute("tenure");
//int tenure = 2; // revert back to session later
int colspan = 4;
int colspan1 = 1;
if(tenure == 2) {
  colspan = 5;
  colspan1 = 2;
}

%>

<%

if(request.getParameter("uporin")!=null)
{

  //  insert recurring items

    String df1 = "select id FROM facultygrants.budget_master where year!=0 and year<=" + tenure;
    //out.println(df1);
    Statement ins1 = conn.createStatement();
    ResultSet rins1 = ins1.executeQuery(df1);
    rins1.beforeFirst();
    while(rins1.next())
    {
      
        if(request.getParameter(rins1.getString(1))!=null)
        {
          int ramt = Integer.parseInt(request.getParameter(rins1.getString(1)));
            String inqf = "";
            String chk1 = "select * from facultygrants.budget b where reg_proceeding_no='"+appn+"' and budget_id="+rins1.getInt(1);
            Statement chk1s = conn.createStatement();
            ResultSet rchk1s = chk1s.executeQuery(chk1);
            if(rchk1s.next())
            {
                inqf = "update facultygrants.budget set amount="+ramt+" where reg_proceeding_no ='"+appn+"' and budget_id ="+rins1.getInt(1);


            }
            else
            {
                inqf = "insert facultygrants.budget(reg_proceeding_no,budget_id,amount) values('"+appn+"',"+rins1.getInt(1)+","+ramt+")";
            }

            Statement inqf1 = conn.createStatement();
            int s = inqf1.executeUpdate(inqf);

            inqf1.close();

                  
    chk1s.close();
    rchk1s.close();
      }

    }


    ins1.close();
    rins1.close();







    // update non recurring items

    if(request.getParameter("alcnt")!=null)
    {

      int alcount = Integer.parseInt(request.getParameter("alcnt"));
      if(alcount>0)
      {
        for(int z=1; z<=alcount; z++)
        {
            String aln = request.getParameter("alnm_"+z);
            String almk = request.getParameter("almake_"+z);
            int alcst = Integer.parseInt(request.getParameter("alcst_"+z));
            String alrmk = request.getParameter("alrmk_"+z);
            int bgid = Integer.parseInt(request.getParameter("albgid_"+z));
            int budg_id = Integer.parseInt(request.getParameter("albid_"+z));

            String unq1 = "update facultygrants.budget_master set make='"+almk+"',remarks='"+alrmk+"',head_name ='"+aln+"' where id="+bgid;

            Statement st13 = conn.createStatement();
            st13.executeUpdate(unq1);
            
            String upq1 = "update facultygrants.budget set amount ="+alcst+" where id ="+budg_id;
            st13.executeUpdate(upq1);


            st13.close();
        }
      }

    }


    // INSERT non recurring items

    if(request.getParameter("newcnt")!=null)
    {

      int alcount = Integer.parseInt(request.getParameter("newcnt"));
      if(alcount>0)
      {
        for(int z=1; z<=alcount; z++)
        {
          String aln = "";
          String almk = "";
          int alcst = 0;
          String alrmk="";
            if(request.getParameter("nm_"+z)!=null)
            aln = request.getParameter("nm_"+z);
            if(request.getParameter("make_"+z)!=null)
            almk = request.getParameter("make_"+z);
            if(request.getParameter("cst_"+z)!=null)
            alcst = Integer.parseInt(request.getParameter("cst_"+z));
            if(request.getParameter("rmk_"+z)!=null )
            alrmk = request.getParameter("rmk_"+z);
            if(aln!="" && almk !="" && alcst !=0 && alrmk !="")
{
            String unq1 = "insert into facultygrants.budget_master(head_name,make,remarks) values('"+aln+"','"+almk+"','"+alrmk+"')";
            //out.println(unq1);
            Statement st13 = conn.createStatement();
            st13.executeUpdate(unq1);

            String slqw = "select id from facultygrants.budget_master bm where head_name ='"+aln+"' and make='"+almk+"' and remarks ='"+alrmk+"'";

            //out.println(slqw);
            int budg_id = 0;

            ResultSet rsd = st13.executeQuery(slqw);
            rsd.next();
            budg_id= rsd.getInt(1);
            rsd.close();
            
            String upq1 = "insert into facultygrants.budget(reg_proceeding_no,budget_id,amount) values('"+appn+"',"+budg_id+","+alcst+")";
            //out.println(upq1);
                     st13.executeUpdate(upq1);
}
        }
      }

    }


    

}

%>




<style>
  th, td {
    text-align: center;
  }
</style>
<br><br>
<center>
<%

    String head_name = "";
    int id = 0;
    int year = 0;
    String prev = "";

    String df = "select distinct head_name FROM facultygrants.budget_master where year!=0 and year<=" + tenure;

    Statement stmt = null;
    ResultSet rs = null;
    
    Statement stmt1 = null;
    ResultSet rs1 = null;
    
    if (conn != null) {
      int tot = 0;
%>
      <form method="post">
        <table style="width: 60%;">
            <tr>
                <th>SNo</th>
                <th>Head</th>
                <th>1st Year</th>
                <% if (tenure == 2) { %>
                    <th>2nd Year</th>
                <% } %>
                <th>Total</th>
            </tr>
            <tr>
              <th colspan="<%= colspan %>">
                &nbsp;
              </th>
            </tr>
            <tr>
              <th style="text-align: left;" colspan="<%= colspan %>">
                Recurring
              </th>
            </tr>
            <tr>
              <th colspan="<%= colspan %>">
                &nbsp;
                <input type="hidden" value="<%= budget %>" id="budg">
              </th>
            </tr>
<%
        stmt = conn.createStatement();
        rs = stmt.executeQuery(df); 
        int isr = 1;

        while (rs.next()) {
            head_name = rs.getString("head_name");

            String df2 = "select * FROM facultygrants.budget_master where head_name='" + head_name + "' and year!=0 and year<=" + tenure;

            stmt1 = conn.createStatement();
            rs1 = stmt1.executeQuery(df2); 
            
            boolean firstYearDisplayed = false;
            boolean secondYearDisplayed = false;
            while (rs1.next()) {
              prev = rs1.getString("head_name");
                if (rs1.getInt("year") == 1 && !firstYearDisplayed) {
%>
                    <tr>
                        <td><%= isr %></td>
                        <td><%= head_name.toUpperCase() %></td>

                        <td>

                          <%
                            Statement st3 = conn.createStatement();
                            int val = 0;
                            String qu = "select * from facultygrants.budget b where reg_proceeding_no='" + appn + "' and budget_id=" + rs1.getInt("id");
                            ResultSet rs3 = st3.executeQuery(qu);
                            if(rs3.next()) {
                              
                                rs3.beforeFirst();
                                rs3.next();
                                val = rs3.getInt("amount");
                                tot += val;
                            }
                            rs3.close();
                            st3.close();
                          %>
                          <input type="text" oninput="onlynumber(this.id)" onchange="function_to_write(this.className)"  value="<%= val %>" class="<%= rs1.getString("head_name") %>" id="<%= rs1.getInt("id") %>" name="<%= rs1.getInt("id") %>">
                        </td>
<%
                    firstYearDisplayed = true;
                }

                if (rs1.getInt("year") == 2 && !secondYearDisplayed) {
                    if (tenure == 2) {
%>
                    <td>
                      <%
                      Statement st3 = conn.createStatement();
                      int val = 0;
                      String qu = "select * from facultygrants.budget b where reg_proceeding_no='" + appn + "' and budget_id=" + rs1.getInt("id");
                      ResultSet rs3 = st3.executeQuery(qu);
                      if(rs3.next()) {
                          rs3.beforeFirst();
                          rs3.next();
                          val = rs3.getInt("amount");
                          tot += val;
                      }
                      rs3.close();
                      st3.close();
                    %>
                      <input type="text" oninput="onlynumber(this.id)" onchange="function_to_write(this.className)" value="<%= val %>" class="<%= rs1.getString("head_name") %>" id="<%= rs1.getInt("id") %>" name="<%= rs1.getInt("id") %>">
                    </td>
<%
                    }
                    secondYearDisplayed = true;
                }
            }
%>
              <td>
                <input type="hidden" class="rec" id="<%= head_name %>_" value="<%= tot %>">
                <b><span id="<%= head_name %>*"><%= tot %></span></b>
              </td>
<%
            isr++;
            tot=0;
        }
%>
<tr>
  <th colspan="<%= colspan %>">
    &nbsp;
  </th>
</tr>
        <tr>
          <th colspan="<%= colspan -1 %>" style="text-align: right;">
            <input type="hidden" value="0" id="sum_rec">
            A - Total:
            &nbsp;
          </th>
          <th>
            <span id="sum_rec*">0</span>
          </th>
        </tr>

        <tr>
          <th colspan="<%= colspan %>">
            &nbsp;
          </th>
        </tr>

        <tr>
          <th colspan="<%= colspan-1 %>" style="text-align: left;">
            Non-Recurring (Minor Equipment only) (up to 20%)
          </th>
          <th>
            <!-- <button onclick="duplicateRow()">+</button> -->
             <input type="button" onclick="duplicateRow()" value="+">
          </th>
        </tr>
        <tr>
          <th colspan="<%= colspan %>">
            &nbsp;
          </th>
        </tr>
        <tr>
          <th colspan="<%= colspan1 %>">Name of Equipment</th>
          <th>Make</th>
          <th>Cost</th>
          <th>Remarks</th>
        </tr>
        <tbody id="equipmentRows">

          <%
          int alcnt = 1;
            String non_res = "select bm.head_name, bm.make, b.amount, bm.remarks, b.id, b.budget_id from facultygrants.budget_master bm join facultygrants.budget b on b.budget_id = bm.id where reg_proceeding_no ='"+appn+"' and bm.year=0 and bm.status =1";
            //out.println(non_res);
            Statement stn1 = conn.createStatement();
            ResultSet rsn1 = stn1.executeQuery(non_res);
            if(rsn1.next())
            {
              rsn1.beforeFirst();
              while(rsn1.next())
              {
                %>
                <tr>
                  <td colspan="<%= colspan1 %>">
                    <input type="hidden" id="albid_<%= alcnt %>" value="<%= rsn1.getInt(5) %>" name="albid_<%= alcnt %>">
                    <input type="hidden" id="albgid_<%= alcnt %>" value="<%= rsn1.getInt(6) %>" name="albgid_<%= alcnt %>">
                    <input type="text" id="alnm_<%= alcnt %>" value="<%= rsn1.getString(1) %>" name="alnm_<%= alcnt %>">
                  </td>          
                  <td>
                    <input type="text" id="almake_<%= alcnt %>" required="required" value="<%= rsn1.getString(2) %>" name="almake_<%= alcnt %>">
                  </td>
                  <td>
                    <input oninput="onlynumber(this.id)" onchange="function_nrec()" type="text"  required="required" value="<%= rsn1.getString(3) %>" id="alcst_<%= alcnt %>" name="alcst_<%= alcnt %>" class="nrec">
                  </td>
                  <td>
                    <input type="text" id="alrmk_<%= alcnt %>"  required="required" value="<%= rsn1.getString(4) %>" name="alrmk_<%= alcnt %>">
                  </td>
                </tr>
                <%
                alcnt++;
              }
            }
          %>
          <input type="hidden" name="alcnt" value="<%= alcnt-1 %>">
        <tr id="to_rep">
          <td colspan="<%= colspan1 %>">
            <input type="text" id="nm_1" name="nm_1">
          </td>          
          <td>
            <input type="text" id="make_1" name="make_1">
          </td>
          <td>
            <input oninput="onlynumber(this.id)" onchange="function_nrec()" type="text" value="0" id="cst_1" name="cst_1" class="nrec">
          </td>
          <td>
            <input type="text" id="rmk_1" name="rmk_1">
          </td>
        </tr>

        </tbody>
        </table>

        <table style="width: 60%;">
          <tr>
            <td>
              <input type="hidden" value="1" id="rowcont" name="newcnt">
              <input type="hidden" value="0" id="sum_nrec">
            </td>
          </tr>
  
          
          <tr>
            <th colspan="<%= colspan %>">
              &nbsp;
            </th>

          </tr>

          <tr>
            <th colspan="<%= colspan-1 %>" style="text-align: right;">
              B - Total:
            </th>
            <th style="min-width: 28px;">
              <span id="sum_nrec*">0</span>
            </th>
          </tr>
  
          <tr>
            <th colspan="<%= colspan-1 %>" style="text-align: right;">
              Grand Total
            </th>
            <th>
              <input type="hidden" value="0" id="sum_to_rec">
              <span id="fintot">0</span>
            </th>
          </tr>

          <tr>
            <th colspan="<%= colspan %>">
                <input type="submit" name="uporin"></form>
            </th>

          </tr>
        </table>
      
        <br>
        
      </center>

<script>
  let rowCounter = 1;
  let budget = document.getElementById("budg").value;

  window.onload = function() {
    recsum();
    nrecsum();
    totsum();
};

  function function_nrec()
  { 
    recsum();
    nrecsum();
    totsum();
  }

  function checkvalidation()
  { 
    
    nrecsum();
    totsum();
  }

  function function_to_write(className) {
    console.log('Class name received:', className);

    const inputs = document.getElementsByClassName(className);
    const values = [];

    var su = 0;

    for (let i = 0; i < inputs.length; i++) {
        values.push(inputs[i].value);
    }

    for (let i = 0; i < values.length; i++) {
        su += parseInt(values[i]);
    }

    var cn = className + "_";
    var inv = document.getElementById(cn);

    getLimit(className, function(lmt) {
        console.log("Limit:", lmt);

        var lmt1 = lmt*budget;
        console.log(su);
        console.log(lmt1);

        if(lmt1 >0)
        {
        if (lmt1 < su) {
            alert("Head's Limit is exceeded");

            for (let i = 0; i < inputs.length; i++) {
                inputs[i].value = 0;
            }

            su = 0;
        }
      }

        var dn = className + "*";
        var inv1 = document.getElementById(dn);
        inv1.innerHTML = su;
        inv.value = su;

        console.log(inputs);
        console.log(su);

        recsum();
        nrecsum();
        totsum();
    });
}



function totsum()
{
  var fin_s_rec = document.getElementById("sum_rec");
  var fin_s_nrec = document.getElementById("sum_nrec");
  var fin_t = document.getElementById("sum_to_rec");
  var d = parseInt(fin_s_nrec.value) + parseInt(fin_s_rec.value);
  fin_t.value = d;
  
  if(budget<=d)
{
  alert("Total Limit is exceeded");
  
}


  var fintot = document.getElementById("fintot");
  fintot.innerHTML = d;
}



function recsum()
{
  const inputs = document.getElementsByClassName("rec");
  const values = [];

  var fin_s_rec = document.getElementById("sum_rec");
  var su = 0;

for (let i = 0; i < inputs.length; i++) {
    values.push(inputs[i].value);
}


for (let i = 0; i < values.length; i++) {
    su = su + parseInt(values[i]);
}

fin_s_rec.value = su;

document.getElementById("sum_rec*").innerHTML = su;
}



function nrecsum()
{
  const inputs = document.getElementsByClassName("nrec");
  const values = [];

  var fin_s_rec = document.getElementById("sum_nrec");
  var su = 0;

for (let i = 0; i < inputs.length; i++) {
    values.push(inputs[i].value);
}


for (let i = 0; i < values.length; i++) {
    su = su + parseInt(values[i]);
}

var bl = 0.2;

 var nb = budget * bl;

if(su>=nb)
{
    alert("Non Recurring Limit is exceeded");
}



fin_s_rec.value = su;

document.getElementById("sum_nrec*").innerHTML = su;
}


function duplicateRow() {
    var df = document.getElementById("rowcont");
    rowCounter++;
    const original = document.getElementById("to_rep");
    const clone = original.cloneNode(true);

    clone.id = "to_rep_" + rowCounter;

    // Update ids and names in the cloned row
    clone.querySelectorAll("input").forEach((input) => {
      const name = input.name;
      const id = input.id;

      // Increment the id and name attributes by replacing the last digit
      input.id = id.replace(/\d+$/, rowCounter);
      input.name = name.replace(/\d+$/, rowCounter);

      // Ensure the `onchange` attribute is set for the cost input field
      if (input.id.startsWith('cst_')) {
        input.setAttribute('onchange', 'function_nrec()');
        // Set the initial value to 0
        input.value = 0;
      } else {
        // Clear the value of non-cost input fields
        input.value = "";
      }
    });

    df.value = rowCounter;

    // Append the cloned row to the table
    document.getElementById("equipmentRows").appendChild(clone);
}


function getLimit(d, callback) {
    var xhr = new XMLHttpRequest();
    var url = "limitChange.jsp?head=" + encodeURIComponent(d);
    xhr.open("GET", url, true);
    xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
            var df = xhr.responseText.trim();
            console.log("Limit received from server:", df);
            callback(parseFloat(df));
        }
    };
    xhr.send();
}


function onlynumber(id) {
    var input = document.getElementById(id);
    
    // Replace any non-digit character with an empty string
    input.value = input.value.replace(/\D/g, '');
}



</script>
<%
    } else {
        out.println("Connection is null.");
    }
%>

<%@ include file="dbClose.jsp" %>
