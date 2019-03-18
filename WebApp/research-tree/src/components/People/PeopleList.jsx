import React, { Component } from 'react'

import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import {fetchUsers} from '../../actions/PeopleAction'
import PeopleCard from './PeopleCard';

class PeopleList extends Component {
    componentWillMount() {
        this.props.fetchUsers(this.props.token);
    }

    render() {
        
        const peopleItems = this.props.users.map(user => (
            <div key={user.id}>
            
                <PeopleCard title={user.firstName} description={user.lastname} date={user.standing}/>
            </div>
        ));
        return (
        <div>
            <h1 style={{ color: '#74997a', textAlign: 'center' }}>People</h1>
            {peopleItems}
        </div>
        )
    }
}

PeopleList.propTypes = {
    fetchUsers: PropTypes.func.isRequired
}

const mapStateToProps = state => ({
    token: state.user.user.token,
    users: state.people.users,
    error: state.people.error
  })

export default connect(mapStateToProps, { fetchUsers })(PeopleList);