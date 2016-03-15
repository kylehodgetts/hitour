class Data extends React.Component {
  componentDidMount () {
    $('.audienceSelector').material_select();
  }
  render () {
    return (
      <div>
        <GenericList getUrl={this.props.getUrl} />
        <form style={{marginBottom: '100px'}} onSubmit={this.showProgressBar} id="datumForm" className="col s12" encType="multipart/form-data" action={this.props.postUrl} method="post" >
                  <div className="row">
            <div className="input-field col s12">
                <input id="datum[title]" type="text" name="title" className="validate" required/>
                <label htmlFor="datum[title]">Title</label>
            </div>
          </div>
          <div className="row">
            <div className="input-field col s12">
                <textarea name="description" id="datum[description]" className="materialize-textarea" required></textarea>
                <label htmlFor="datum[description]">Description</label>
            </div>
          </div>
          <div className="file-field input-field">
            <div className="btn">
              <span>File</span>
              <input type="file" name="file" id="datum[file]" required/>
            </div>
            <div className="file-path-wrapper">
              <input className="file-path validate" type="text" placeholder="Upload your file here" />
            </div>
          </div>
          <div className="row">
            <div className="input-field col s12">
              <select id="datum[audience]" className="audienceSelector" name="datum[audience]">
                {this.props.audiences.map(function(audience) {
                  return (
                    <option value={audience.id} key={audience.id} >{audience.name}</option>
                  );
                }, this)}
              </select>
              <label htmlFor="datum[audience]">Initial Audience Datum is available to:</label>
            </div>
          </div>
          <label>Note: More Audiences can be added later</label>
          <button className="btn right blue waves-effect waves-light"
                  type="submit" name="action">Submit
            <i className="material-icons right">send</i>
          </button>
        </form>
      </div>
    );
  }
  showProgressBar() {
    $('.progress-message').text('Uploading Media');
    $('.progress-overlay').fadeIn(200);
  }
}

Data.displayName = "Data";
Data.propTypes = {
  getUrl: React.PropTypes.string.isRequired,
  postUrl: React.PropTypes.string.isRequired,
  audiences: React.PropTypes.array.isRequired
}
