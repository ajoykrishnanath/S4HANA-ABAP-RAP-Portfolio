projection;
use draft;

define behavior for ZAN_C_PO_Header //alias <alias_name>
{
  use create;
  use update;
  use delete;

  use action SubmitPO;

  use association _Item { create; with draft; }
}

define behavior for ZAN_C_PO_Item //alias <alias_name>
{
  use update;
  use delete;

  use association _Header { with draft; }
}
