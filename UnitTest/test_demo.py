#
# File: test_ex-1.py
# Auth: Martin Burolla
# Date: 9/5/2021
# Desc:
#

import sia
import pytest

dbConn = None

#
# Fixture
#

# @pytest.fixture
# def dbConn():
#   dbConn = "Connected"
#   return dbConn

#
# Setup/Tear Down
#

def setup_module(module):
  global dbConn
  # Create test user data, initializd the db with data.
  dbConn = "Connected"

def teardown_module(module):
  global dbConn
   # delete test user data, delete test data.
  dbConn = None

#
# Test Methods
#

def test_hello_world():
  s = "Hello World"
  assert s == 'Hello World'

def test_DoubleList_Integers():
  # Arrange
  l = [1,2,3,4]

  # Act
  doubleList = sia.doubleList(l)

  # Assert  
  assert doubleList[0] == 2, "Value 1 expected to be 2"
  assert doubleList[1] == 4, "Value 2 expected to be 4"
  assert doubleList[2] == 6, "Value 3 expected to be  6"
  assert doubleList[3] == 8, "Value4 expected to be 8"

  # Clean up (optionally)
    
def test_DoubleList_Strings():
  # Arrange
  l = ["test"]

  # Act
  doubleList = sia.doubleList(l)

  # Assert  
  assert doubleList[0] == "testtest", "Test is the expected value"


def test_Add_Numbers_Integers():              
  # Arrange
  x = 1
  y = 2

  # Act 
  r = sia.addNumbers(1,2)

  # Assert
  assert dbConn == "Connected"
  assert r == 3, "add() function failed"

  # Clean up (nothing to cleanup here...)

def test_Concat_Strings_Function():             
  # Arrange
  x = "Hello"
  y = "World"

  # Act 
  r = sia.concatStrings(x, y)

  # Act 
  assert dbConn == "Connected"
  assert "Hello" in r, "Hello not in Hello World"
  assert "World" in r, "World not in Hello World"

  # Clean up (nothing to cleanup here...)


def test_SortList_Condition1():
  # Arrange
   
  # Act 
   
  # Assert 
  
  # Cleanup (Optional)

  assert True

def test_sortList():
    #Arrange
    testList = [3,1,2]

    #Act
    sortedList = sia.sortList(testList)

    #Assert
    assert sortedList[0] == 1, "Expected to be equal to 1."
    assert sortedList[1] == 2, "Expected to be equal to 2."
    assert sortedList[2] == 3, "Expected to be equal to 3."
