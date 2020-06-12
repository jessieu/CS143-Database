<!DOCTYPE html>
<html>
  <head>
    <title>CS143 Project1</title>
  </head>
  <body>
  <form action="query.php" method="GET">
     <p>Type an SQL query in the following box:</p>
     <p>Example: SELECT * FROM Actor WHERE id=10;</p></p>
     <textarea name="query" cols="60" rows="8">
       <?php print "$query" ?>
     </textarea><br/>
     <input type="submit" value="Submit" />
  </form>
  <p><small>Note: tables and fields are case sensitive.</small></p>

  <?php
      // retrieve the data entered into the textarea
      $query = $_GET["query"];
      // notidy user if they hit submit without any queries
      if (empty(query)) {
        die("Please fill in a query before submitted.");
      }

      // connect to database
      $db_connection = mysql_connect("localhost", "cs143", "");
      if (!$db_connection){
        die('Could not connect: ' . mysql_error());
      }
      // select database
      mysql_select_db("CS143", $db_connection);

      // issue a query to database
      $result = mysql_query($query);
      if (!$result) {
        echo 'Could not run query: ' . mysql_error();
        exit;
      }

      // print out the query result
      echo "Your query:<br>";
      echo $query;
      echo "<h3>Results from MySQL:</h3>";
      echo "<table border=1 solid width='100%'>";

      $field_nums = mysql_num_fields($result);
      $i = 0;

      // print table header
      echo "<tr align='center'>";
      for (;$i < $field_nums; $i = $i + 1) {
        $field = mysql_fetch_field($result, $i);
        echo "<th>" . $field->name . "</th>";
      }
      echo "</tr>";

      // print cell items
      while ($row = mysql_fetch_row($result)) {
        echo "<tr align='center'>";
        for ($i = 0; $i < $field_nums; $i = $i + 1) {
          if(is_null($row[$i]))
				      echo "<td>N/A</td>";
          else
            echo "<td>" . $row[$i] . "</td>";
        }
        echo "</tr>";
      }
    echo "</table>";

    // close connection to database
    mysql_close($db_connection);
  ?>

  </body>
</html>
