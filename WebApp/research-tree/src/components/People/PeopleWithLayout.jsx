import React, { Component } from 'react'
import {Redirect} from 'react-router-dom'
import {connect} from 'react-redux'

import { Layout } from 'antd';

import People from './People'

import Navbar from '../Navbar';

const {
    Content, Sider, Header,
  } = Layout;

class PeopleWithLayout extends Component {
    render() {
        return (
            <div>
                {
                    this.props.user.token ? 
                    renderPeople(): 
                    <Redirect to='/Login' />
                }
            </div>
        )
    }
}

function renderPeople() {
    return(
        //try layout
        <div>
            <Layout>
            <Header style={{background:'#c1e791', position: 'fixed', zIndex: 10,height: '8%', width: '100%' }}>
            <div className="logo"></div>
            <h1 style={{color:'white'}}>ResearchTree</h1>
            </Header>
                <Layout>
                    <Sider>
                        <Navbar pageNum={['2']} />
                    </Sider>
                    <Content style={{marginTop: '6%'}}>
                        <People />
                    </Content>
                </Layout>
            </Layout>
        </div>
    );
}

const mapStateToProps = state => ({
    user: state.user.user
})

export default connect(mapStateToProps, {})(PeopleWithLayout);