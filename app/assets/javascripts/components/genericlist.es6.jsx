class GenericList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      items: this.props.items
    };
  }

  handleAddEntry() {
    console.log("Added!");
  }

  render () {
    return (
      <div className="col s12">
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
            <input id="data" type="text" />
            <label htmlFor="data">New Entry</label>
            <button className="btn blue right waves-effect waves-light col s3"
                    onClick={this.handleAddEntry.bind(this)}>
              Add
              <i className="material-icons right">send</i>
            </button>
          </div>
        </div>
      </div>
    );
  }
}

GenericList.displayName = "List";
GenericList.propTypes = {
  items: React.PropTypes.array.isRequired
}
