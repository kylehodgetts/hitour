class GenericList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      items: this.props.items
    };
  }

  componentDidMount() {
    $("#form-list").on("submit", this.handleAddEntry);
  }

  handleAddEntry(e) {
    e.preventDefault();
    console.log($(this).serialize());
    $.ajax({
      url: link,
      type: "POST",
      data: $(this).serialize(),
      success: function() {
        this.setState({
          items: this.state.items
        })
      }
    });
  }

  render () {
    return (
      <form id="form-list" className="col s12">
        <div className="collection">
          {this.state.items.map(function(item) {
            return(
              <div key={item.id} className="collection-item">
                <div>
                  {item.data}
                  <a href="#!" className="secondary-content">
                    <i className=" blue-text material-icons">delete_forever</i>
                  </a>
                </div>
              </div>
            );
          })}
        </div>
        <div className="input-field col s12">
          <div className="col s9">
            <input name="entry" id="data" type="text" />
            <label htmlFor="data">New Entry</label>
            <button type="submit"
                    className="btn blue right waves-effect waves-light col s3">
              Add
              <i className="material-icons right">send</i>
            </button>
          </div>
        </div>
      </form>
    );
  }
}

GenericList.displayName = "List";
GenericList.propTypes = {
  items: React.PropTypes.array.isRequired
}
