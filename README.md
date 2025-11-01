# Roblox-Data-Store-Handler

This module provides a safe and easy way to handle Roblox DataStores.

Functions:

SetData(DataStore, DKey, TKey, Value) – Updates an existing key or creates a new key in a DataStore table.

GetData(DataStore, DKey, TKey) – Retrieves the value of a key from a DataStore table.

Parameters:

DataStore – The DataStore object you want to use.

DKey – The key representing the table inside the DataStore.

TKey – The key inside the table that you want to set or get.

Value – The value to assign to TKey (used with SetData).

Return values:

SetData returns a result code indicating whether the operation succeeded, updated an existing key, or created a new key.

GetData returns the value of TKey (if it exists) and a result code indicating success or failure.
