Database Design and the E-R Model

### The Entity-Relationship Model

The entity-relationship ( E-R ) data model was developed to facilitate database design by allowing specification of an enterprise schema that represents the overall logical structure of a database.
The E-R model is very useful in <u>mapping the meanings and interactions of real-world enterprises onto a conceptual schema</u>.

1. Entity Sets

   - An **entity** is a “thing” or “object” in the real world that is distinguishable from all other objects.
   - An **entity set** is a set of entities of the same type that share the same properties, or attributes.
     - Not need to be disjoin. An element in an entity set can belong to other entity set.
   - An entity is represented by a set of **attributes**. Attributes are descriptive properties possessed by each member of an entity set.

2. Relationship Sets

   - A **relationship** is an association among several entities.
   - A **relationship set** is a set of relationships of the same type. Formally, it is a mathematical relation on n ≥ 2 (possibly non-distinct) entity sets. If E~1~ , E~2~ , . . . , E~n~ are entity sets, then a relationship set R is a subset of {(e~1~ , e~2~ , . . . , e~n~ ) | e~1~∈ E~1~ , e~2~ ∈ E~2~ , . . . , e~n~∈ E~n~ } where (e~1~ , e~2~ , . . . , e~n~ ) is a relationship.
   - The association between entity sets is referred to as **participation**; that is, the entity sets E~1~ , E~2~ , . . . , E~n~  participate in relationship set R.

   <img src="/home/weilan/.config/Typora/typora-user-images/image-20200221143209996.png" alt="image-20200221143209996" style="zoom: 67%;" />

   - **Descriptive Attributes**

     <img src="/home/weilan/.config/Typora/typora-user-images/image-20200221143440368.png" alt="image-20200221143440368" style="zoom:67%;" />

     

3. Attributes

   - For each attribute, there is a set of permitted values, called the **domain**, or  value set, of that attribute.

   - Attribute Types:

     - Simple and composite attributes. 

       <img src="/home/weilan/.config/Typora/typora-user-images/image-20200221151559283.png" alt="image-20200221151559283" style="zoom:67%;" />

     - Derived Attributes. The value for this type of attribute can be derived from  the values of other related attributes or entities.

       - Suppose that the instructor entity set has an attribute age that indicates the instructor’s age. If the instructor entity set also has an attribute date of birth, we can calculate age from date of birth and the current date. Thus, age is a derived attribute.

### Constraints

1. Mapping Cardinalities

   **Mapping cardinalities**, or cardinality ratios, express the <u>number of entities</u> to which another entity can be associated via a relationship set.

   For a binary relationship set R between entity sets A and B, the mapping cardinality must be one of the following:

   - **One-to-one**. An entity in A is associated with at most one entity in B, and an entity in B is associated with at most one entity in A. 
   - **One-to-many**. An entity in A is associated with any number (zero or more) of entities in B. An entity in B, however, can be associated with at most one entity in A. 

   <img src="/home/weilan/.config/Typora/typora-user-images/image-20200221152047324.png" alt="image-20200221152047324" style="zoom:67%;" />

   - **Many-to-one**. An entity in A is associated with at most one entity in B. An entity in B, however, can be associated with any number (zero or more) of entities in A. 

   - **Many-to-many**. An entity in A is associated with any number (zero or more) of entities in B, and an entity in B is associated with any number (zero or more) of entities in A. 

     <img src="/home/weilan/.config/Typora/typora-user-images/image-20200221152203981.png" alt="image-20200221152203981" style="zoom:67%;" />

2. Participation Constraints

   - The participation of an entity set E in a relationship set R is said to be **total** if every entity in E participates in at least one relationship in R. 
     - we expect every student entity to be related to at least one instructor through the advisor relationship. Therefore the participation of student in the relationship set advisor is total.
   - If only some entities in E participate in relationships in R, the participation of entity set E in relationship R is said to be **partial**.
     - An instructor need not advise any students. Hence, it is possible that only some of the instructor entities are related to the student entity set through the advisor relationship, and the participation of instructor in the advisor relationship set is therefore partial.

3. Keys

   - No two entities in an entity set are allowed to have exactly the same value for all attributes.
   - A key for an entity is a set of attributes that suffice to distinguish entities from each other.

### Removing Redundant Attributes in Entity Sets

Once the entities and their corresponding attributes are chosen, the relationship sets among the various entities are formed. These relationship sets may result in a situation where attributes in the various entity sets are redundant and need to be removed from the original entity sets.

consider the entity sets instructor and department:

- The entity set instructor includes the attributes ID , name, dept name, and salary, with ID forming the primary key.
- The entity set department includes the attributes dept name, building, and bud-
  get, with dept name forming the primary key.

We model the fact that each instructor has an associated department using a relationship set inst dept relating instructor and department.

The attribute dept name appears in both entity sets. Since it is the primary key for the entity set department, it is redundant in the entity set instructor and needs to be removed.

### Entity-Relationship Diagrams

1. Basic Structure

   An E-R diagram consists of the following major components:

   - **Rectangles divided into two parts** represent entity sets.

   - **Diamonds** represent relationship sets.

   - **Undivided rectangles** represent the attribute of a relationship set.

   - **Lines** link entity sets to relationship sets.

   - **Dashed lines** link attributes of a relationship set to the relationship set.

   - **Double lines** indicate total participation of an entity in a relationship set.

   - **Double diamonds** represent identifying relationship sets linked to weak entity sets

     <img src="/home/weilan/.config/Typora/typora-user-images/image-20200221154746152.png" alt="image-20200221154746152" style="zoom:67%;" />

2. Mapping Cardinality

   <img src="/home/weilan/.config/Typora/typora-user-images/image-20200221154816462.png" alt="image-20200221154816462" style="zoom:67%;" />![image-20200221155051188](/home/weilan/.config/Typora/typora-user-images/image-20200221155051188.png)

   <img src="/home/weilan/.config/Typora/typora-user-images/image-20200221155051188.png" alt="image-20200221155051188" style="zoom:67%;" />

   - The line between advisor and student has a cardinality constraint of `1..1`, meaning the minimum and the maximum cardinality are both 1. That is, each student must have exactly one advisor. 
   - The limit `0..∗` on the line between advisor and instructor indicates that an instructor can have zero or more students. Thus, the relationship advisor is one-to-many from instructor to student, and further the participation of student in advisor is total, implying that a student must have an advisor.

3. Complex Attributes

   <img src="/home/weilan/.config/Typora/typora-user-images/image-20200221160959115.png" alt="image-20200221160959115" style="zoom:67%;" />

4. Roles

   <img src="/home/weilan/.config/Typora/typora-user-images/image-20200221161030548.png" alt="image-20200221161030548" style="zoom:67%;" />

5. Nonbinary Relationship Sets

   <img src="/home/weilan/.config/Typora/typora-user-images/image-20200221161113836.png" alt="image-20200221161113836" style="zoom:67%;" />

6. Weak Entity Sets

   - An entity set that does <u>not have sufficient attributes to form a primary key</u> is termed a **weak entity set**. An entity set that has a primary key is termed a **strong entity set**.

   - For a weak entity set to be meaningful, it must be associated with another
     entity set, called the identifying or owner entity set. <u>Every weak entity must</u>
     <u>be associated with an identifying entity</u>; that is, the weak entity set is said to be existence dependent on the identifying entity set.

   - The **discriminator** of a weak entity set is a set of attributes that allows us to distinguish among all those entities in the weak entity set that depend on one particular strong entity.

   - The <u>primary key of a weak entity set</u> is formed by the primary key of the identifying entity set, plus the weak entity set’s discriminator.

     <img src="/home/weilan/.config/Typora/typora-user-images/image-20200221162317551.png" alt="image-20200221162317551" style="zoom:67%;" />

     - The discriminator of a weak entity is underlined with a dashed, rather than a solid, line.
     - The relationship set connecting the weak entity set to the identifying  strong entity set is depicted by a double diamond.

   - A weak entity set can participate in relationships other than the identifying relationship.

### Reduction to Relational Schemas

1. Representation of Strong Entity Sets with Simple Attributes

   Let E be a strong entity set with only simple descriptive attributes a~1~ , a~2~ , . . . , a~n~. We represent this entity by a schema called E with n distinct attributes. <u>Each tuple</u>
   <u>in a relation on this schema corresponds to one entity of the entity set E.</u>

2. Representation of Strong Entity Sets with Complex Attributes

   When a strong entity set has non-simple attributes, we handle composite attributes by creating a separate attribute for each of the component attributes. 

3. Representation of Weak Entity Sets

   Let A be a weak entity set with attributes a~1~ , a~2~ , . . . , a~m~ . Let B be the strong entity set on which A depends. Let the primary key of B consist of attributes b~1~ , b~2~ , . . . , b~n~ . We represent the entity set A by a relation schema called A with one attribute for each member of the set: {a~1~ , a~2~ , . . . , a~m~ } ∪ {b~1~ , b~2~ , . . . , b~n~}. 

4. Representation of Relationship Sets

   The primary key is chosen as follows:

   - For a binary **many-to-many** relationship, the union of the primary-key attributes from the participating entity sets becomes the primary key.
   - For a binary **one-to-one** relationship set, the primary key of either entity set can be chosen as the primary key. The choice can be made arbitrarily.
   - For a binary **many-to-one or one-to-many** relationship set, the primary key of the entity set on the “many” side of the relationship set serves as the primary key
   - For an n-ary relationship set without any arrows on its edges, the union of the primary key-attributes from the participating entity sets becomes the primary key.
   - For an n-ary relationship set with an arrow on one of its edges, the primary keys of the entity sets not on the “arrow” side of the relationship set serve as the primary key for the schema. Recall that we allowed only one arrow out of a relationship set.

   1. Redundancy of Schemas

      In general, the schema for the relationship set linking a weak entity set to its corresponding strong entity set is redundant and does not need to be present in a relational database design based upon an E-R diagram.

   2. Combination of Schemas

### Entity-Relationship Design Issues

1. Use of Entity Sets versus Attributes
2. Use of Entity Sets versus Relationship Sets
3. Binary versus n-ary Relationship Sets
4. Placement of Relationship Attributes

### Extended E-R Features

1. Specialization
2. Generalization
3. Attribute Inheritance
4. Constraints on Generalizations
5. Aggregation
6. Reduction to Relation Schemas
   1. Representation of Generalization
   2. Representation of Aggregation

### Alternative Notations for Modeling Data

1. Alternative E-R Notations
2. The Unified Modeling Language UML

### Other Aspects of Database Design

1. Data Constraints and Relational Database Design
2. Usage Requirements:

