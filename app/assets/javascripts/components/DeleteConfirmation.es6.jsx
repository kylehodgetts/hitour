class DeleteConfirmation extends React.Component {
  componentDidMount() {
    $('.modal-trigger').leanModal();
  }

  handleTest() {
    console.log("TRIGGERED");
  }

  render () {
    return (
      <div>
        <div id="delete-confirmation" className="modal">
          <div className="modal-content">
            <h4>Confirmation</h4>
            <p>Are you sure you want to delete this record?</p>
            <p>This is permanent and cannot be undone</p>
          </div>
          <div className="modal-footer">
            <a className=" modal-action modal-close waves-effect waves-green btn-flat">
              Yes
            </a>
            <a className=" modal-action modal-close waves-effect waves-green btn-flat">
              No
            </a>
          </div>
        </div>
    </div>
    );
  }
}

DeleteConfirmation.displayName = "DeleteConfirmation";
