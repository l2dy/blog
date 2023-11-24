## Tcl_GetIndexFromObjStruct

Simple static dictionary lookup.

```
// Array of `struct` type, whose first member is a null-terminated string.
// End of array is marked by a NULL string pointer.
static entry_cmd_type entry_cmds[] = {
    /* Global commands */
    { "create", entry_create },
    { "delete", entry_delete },
    { "open", entry_open },
    { "close", entry_close },
    { "search", entry_search },
    { "exists", entry_exists },
    { "imaged", entry_imaged },
    { "installed", entry_installed },
    { "owner", entry_owner },
    { NULL, NULL }
};

// Search for a string in array, save matching index to `cmd_index` and return TCL_OK.
if (Tcl_GetIndexFromObjStruct(interp, objv[1], entry_cmds,
            sizeof(entry_cmd_type), "cmd", 0, &cmd_index) == TCL_OK) {
    entry_cmd_type* cmd = &entry_cmds[cmd_index];
    return cmd->function(interp, objc, objv);
}
```