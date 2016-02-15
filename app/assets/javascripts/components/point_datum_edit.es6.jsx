class PointDatumEdit extends React.Component {
  componentDidMount (){
  	//Set all values from props
  	$('#rank').val(this.props.point_datum.rank);
  }
  render () {
    return (
    	<div>
			<form id="point_datum_form" encType="multipart/form-data" method="post" action={this.props.link_path}>
				<input type="hidden" name="_method" value="patch" />
				<p>Point Name: {this.props.point_name}</p>
				<p>Datum Title: {this.props.datum_title}</p>
				<input type="hidden" name="point_datum[point_id]" value={this.props.point_datum.point_id}/>
				<input type="hidden" name="point_datum[datum_id]" value={this.props.point_datum.datum_id}/>
				<label htmlFor="rank">Rank</label>
				<input type="number" name="point_datum[rank]" id="rank" />
				<input type="submit" value="Submit Changes" />
			</form>
		</div>
	);
  }
}

PointDatumEdit.displayName = "PointDatumEdit";

